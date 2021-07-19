pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package KartenDatenbank is
   
   -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch (Erde), 7 = Planeteninneres (Gestein), 8 = Lava
   
   -- KartenGrafik
   -- Passierbarkeit
   -- Nahrungsgewinnung, Ressourcengewinnung, Geldgewinnung, Wissensgewinnung, Verteidigungsbonus
   
   type KartenListeArray is array (GlobaleDatentypen.Karten_Grund_Enum'Range) of DatenbankRecords.KartenListeRecord;
   KartenListe : KartenListeArray := (
                                      -- Nullwert für Ressourcen, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                      GlobaleDatentypen.Leer => GlobaleKonstanten.LeererWertKartenListe,
                                      
                                      -- Feld
                                      GlobaleDatentypen.Eis =>
                                        (' ',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         0, 0, 0, 1, 0),
                                      GlobaleDatentypen.Wasser =>
                                        (' ',
                                         (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                         1, 0, 1, 1, 0),
                                      GlobaleDatentypen.Flachland =>
                                        (' ',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         2, 1, 1, 0, 0),
                                      GlobaleDatentypen.Tundra =>
                                        (' ',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 2, 1, 1, 0),                                      
                                      GlobaleDatentypen.Wüste =>
                                        (' ',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         0, 1, 1, 1, 0),                                      
                                      -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                      GlobaleDatentypen.Hügel =>
                                        (' ',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 2, 1, 0, 1),                                      
                                      GlobaleDatentypen.Gebirge =>
                                        (' ',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         0, 3, 1, 1, 2),
                                      GlobaleDatentypen.Wald =>
                                        (' ',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 2, 1, 1, 1),                                      
                                      GlobaleDatentypen.Dschungel =>
                                        (' ',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 3, 1, 1, 2),                                      
                                      GlobaleDatentypen.Küstengewässer =>
                                        (' ',
                                         (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                         2, 0, 1, 0, 0),                                      
                                      GlobaleDatentypen.Sumpf =>
                                        (' ',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 1, 1, 1, 2),                                      
                                      -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
                                      GlobaleDatentypen.Hügel_Mit =>
                                        (' ',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Lava =>
                                        (' ',
                                         (GlobaleDatentypen.Lava => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Wolken =>
                                        (' ',
                                         (GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Weltraum =>
                                        (' ',
                                         (GlobaleDatentypen.Weltraum => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Erde =>
                                        (' ',
                                         (GlobaleDatentypen.Unteridrisch => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Gestein =>
                                        (' ',
                                         (GlobaleDatentypen.Planeteninneres => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Unter_Wasser =>
                                        (' ',
                                         (GlobaleDatentypen.Unterwasser => True, others => False),
                                         1, 0, 1, 1, 0),                                      
                                      GlobaleDatentypen.Unter_Küstengewässer =>
                                        (' ',
                                         (GlobaleDatentypen.Unterwasser => True, others => False),
                                         2, 0, 1, 0, 0),
                                      
                                      -- Ressourcen
                                      GlobaleDatentypen.Kohle =>
                                        ('♦',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         0, 2, 1, 0, 0),                                      
                                      GlobaleDatentypen.Eisen =>
                                        ('♦',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         0, 2, 1, 0, 0),                                      
                                      GlobaleDatentypen.Öl =>
                                        ('♦',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         0, 2, 1, 0, 0),                                      
                                      GlobaleDatentypen.Fisch =>
                                        ('≈',
                                         (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                         2, 0, 1, 0, 0),                                      
                                      GlobaleDatentypen.Wal =>
                                        ('≈',
                                         (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                         2, 1, 2, 0, 0),                                      
                                      GlobaleDatentypen.Hochwertiger_Boden =>
                                        ('♦',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         2, 1, 1, 0, 0),                                      
                                      GlobaleDatentypen.Gold =>
                                        ('♦',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         0, 1, 3, 0, 0),
                                      
                                      -- Fluss
                                      GlobaleDatentypen.Flusskreuzung_Vier =>
                                        ('╋',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Fluss_Waagrecht =>
                                        ('━',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Fluss_Senkrecht =>
                                        ('┃',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskurve_Unten_Rechts =>
                                        ('┏',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskurve_Unten_Links =>
                                        ('┓',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskurve_Oben_Rechts =>
                                        ('┗',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskurve_Oben_Links =>
                                        ('┛',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskreuzung_Drei_Oben =>
                                        ('┻',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskreuzung_Drei_Unten =>
                                        ('┳',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskreuzung_Drei_Rechts =>
                                        ('┣',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskreuzung_Drei_Links =>
                                        ('┫',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flussendstück_Links =>
                                        ('╺',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flussendstück_Rechts =>
                                        ('╸',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flussendstück_Unten =>
                                        ('╹',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flussendstück_Oben =>
                                        ('╻',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Fluss_Einzeln =>
                                        ('▪',
                                         (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                         1, 0, 1, 0, 1)
                                     );
   
   procedure StandardKartenDatenbankWiederherstellen;
   
   -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch (Erde), 7 = Planeteninneres (Gestein), 8 = Lava
   
   -- KartenGrafik, Passierbarkeit
   -- Nahrungsgewinnung, Ressourcengewinnung, Geldgewinnung, Wissensgewinnung, Verteidigungsbonus
   
private
   
   KartenListeStandard : constant KartenListeArray := (
                                                       -- Nullwert für Ressourcen, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                       GlobaleDatentypen.Leer => GlobaleKonstanten.LeererWertKartenListe,
                                      
                                                       -- Feld
                                                       GlobaleDatentypen.Eis =>
                                                         (' ',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          0, 0, 0, 1, 0),
                                                       GlobaleDatentypen.Wasser =>
                                                         (' ',
                                                          (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                          1, 0, 1, 1, 0),
                                                       GlobaleDatentypen.Flachland =>
                                                         (' ',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          2, 1, 1, 0, 0),
                                                       GlobaleDatentypen.Tundra =>
                                                         (' ',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 2, 1, 1, 0),                                      
                                                       GlobaleDatentypen.Wüste =>
                                                         (' ',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          0, 1, 1, 1, 0),                                      
                                                       -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                                       GlobaleDatentypen.Hügel =>
                                                         (' ',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 2, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Gebirge =>
                                                         (' ',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          0, 3, 1, 1, 2),
                                                       GlobaleDatentypen.Wald =>
                                                         (' ',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 2, 1, 1, 1),                                      
                                                       GlobaleDatentypen.Dschungel =>
                                                         (' ',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 3, 1, 1, 2),                                      
                                                       GlobaleDatentypen.Küstengewässer =>
                                                         (' ',
                                                          (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                          2, 0, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Sumpf =>
                                                         (' ',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 1, 1, 1, 2),                                      
                                                       -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
                                                       GlobaleDatentypen.Hügel_Mit =>
                                                         (' ',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Lava =>
                                                         (' ',
                                                          (GlobaleDatentypen.Lava => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Wolken =>
                                                         (' ',
                                                          (GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Weltraum =>
                                                         (' ',
                                                          (GlobaleDatentypen.Weltraum => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Erde =>
                                                         (' ',
                                                          (GlobaleDatentypen.Unteridrisch => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Gestein =>
                                                         (' ',
                                                          (GlobaleDatentypen.Planeteninneres => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Unter_Wasser =>
                                                         (' ',
                                                          (GlobaleDatentypen.Unterwasser => True, others => False),
                                                          1, 0, 1, 1, 0),                                      
                                                       GlobaleDatentypen.Unter_Küstengewässer =>
                                                         (' ',
                                                          (GlobaleDatentypen.Unterwasser => True, others => False),
                                                          2, 0, 1, 0, 0),
                                      
                                                       -- Ressourcen
                                                       GlobaleDatentypen.Kohle =>
                                                         ('♦',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          0, 2, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Eisen =>
                                                         ('♦',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          0, 2, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Öl =>
                                                         ('♦',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          0, 2, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Fisch =>
                                                         ('≈',
                                                          (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                          2, 0, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Wal =>
                                                         ('≈',
                                                          (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                          2, 1, 2, 0, 0),                                      
                                                       GlobaleDatentypen.Hochwertiger_Boden =>
                                                         ('♦',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          2, 1, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Gold =>
                                                         ('♦',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          0, 1, 3, 0, 0),
                                      
                                                       -- Fluss
                                                       GlobaleDatentypen.Flusskreuzung_Vier =>
                                                         ('╋',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Fluss_Waagrecht =>
                                                         ('━',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Fluss_Senkrecht =>
                                                         ('┃',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskurve_Unten_Rechts =>
                                                         ('┏',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskurve_Unten_Links =>
                                                         ('┓',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskurve_Oben_Rechts =>
                                                         ('┗',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskurve_Oben_Links =>
                                                         ('┛',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskreuzung_Drei_Oben =>
                                                         ('┻',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskreuzung_Drei_Unten =>
                                                         ('┳',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskreuzung_Drei_Rechts =>
                                                         ('┣',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskreuzung_Drei_Links =>
                                                         ('┫',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flussendstück_Links =>
                                                         ('╺',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flussendstück_Rechts =>
                                                         ('╸',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flussendstück_Unten =>
                                                         ('╹',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flussendstück_Oben =>
                                                         ('╻',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Fluss_Einzeln =>
                                                         ('▪',
                                                          (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                          1, 0, 1, 0, 1)
                                                      );

end KartenDatenbank;

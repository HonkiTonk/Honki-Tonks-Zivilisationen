pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package KartenDatenbank is
   
   -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch (Erde), 7 = Planeteninneres (Gestein), 8 = Lava
   
   -- KartenGrafik, Passierbarkeit
   -- Nahrungsgewinnung, Ressourcengewinnung, Geldgewinnung, Wissensgewinnung, Verteidigungsbonus
   
   type KartenListeArray is array (GlobaleDatentypen.Karten_Grund_Enum'Range) of DatenbankRecords.KartenListeRecord;
   KartenListe : KartenListeArray := (
                                      -- Nullwert für Ressourcen, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                      GlobaleDatentypen.Leer => GlobaleKonstanten.LeererWertKartenListe,
                                      
                                      -- Feld
                                      GlobaleDatentypen.Eis =>
                                        (' ', (1 => True, 3 => True, 4 => True, others => False),
                                         0, 0, 0, 1, 0),                                      
                                      GlobaleDatentypen.Wasser =>
                                        (' ', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                         1, 0, 1, 1, 0),                                      
                                      GlobaleDatentypen.Flachland =>
                                        (' ', (1 => True, 3 => True, 4 => True, others => False),
                                         2, 1, 1, 0, 0),                                      
                                      GlobaleDatentypen.Tundra =>
                                        (' ', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 2, 1, 1, 0),                                      
                                      GlobaleDatentypen.Wüste =>
                                        (' ', (1 => True, 3 => True, 4 => True, others => False),
                                         0, 1, 1, 1, 0),                                      
                                      -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                      GlobaleDatentypen.Hügel =>
                                        (' ', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 2, 1, 0, 1),                                      
                                      GlobaleDatentypen.Gebirge =>
                                        (' ', (1 => True, 3 => True, 4 => True, others => False),
                                         0, 3, 1, 1, 2),
                                      GlobaleDatentypen.Wald =>
                                        (' ', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 2, 1, 1, 1),                                      
                                      GlobaleDatentypen.Dschungel =>
                                        (' ', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 3, 1, 1, 2),                                      
                                      GlobaleDatentypen.Küstengewässer =>
                                        (' ', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                         2, 0, 1, 0, 0),                                      
                                      GlobaleDatentypen.Sumpf =>
                                        (' ', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 1, 1, 1, 2),                                      
                                      -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
                                      GlobaleDatentypen.Hügel_Mit =>
                                        (' ', (1 => True, 3 => True, 4 => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Lava =>
                                        (' ', (7 => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Wolken =>
                                        (' ', (3 => True, 4 => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Weltraum =>
                                        (' ', (4 => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Erde =>
                                        (' ', (6 => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Gestein =>
                                        (' ', (6 => True, others => False),
                                         0, 0, 0, 0, 0),                                      
                                      GlobaleDatentypen.Unter_Wasser =>
                                        (' ', (5 => True, others => False),
                                         1, 0, 1, 1, 0),                                      
                                      GlobaleDatentypen.Unter_Küstengewässer =>
                                        (' ', (5 => True, others => False),
                                         2, 0, 1, 0, 0),
                                      
                                      -- Ressourcen
                                      GlobaleDatentypen.Kohle =>
                                        ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                         0, 2, 1, 0, 0),                                      
                                      GlobaleDatentypen.Eisen =>
                                        ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                         0, 2, 1, 0, 0),                                      
                                      GlobaleDatentypen.Öl =>
                                        ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                         0, 2, 1, 0, 0),                                      
                                      GlobaleDatentypen.Fisch =>
                                        ('≈', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                         2, 0, 1, 0, 0),                                      
                                      GlobaleDatentypen.Wal =>
                                        ('≈', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                         2, 1, 2, 0, 0),                                      
                                      GlobaleDatentypen.Hochwertiger_Boden =>
                                        ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                         2, 1, 1, 0, 0),                                      
                                      GlobaleDatentypen.Gold =>
                                        ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                         0, 1, 3, 0, 0),
                                      
                                      -- Fluss
                                      GlobaleDatentypen.Flusskreuzung_Vier =>
                                        ('╋', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Fluss_Waagrecht =>
                                        ('━', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Fluss_Senkrecht =>
                                        ('┃', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskurve_Unten_Rechts =>
                                        ('┏', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskurve_Unten_Links =>
                                        ('┓', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskurve_Oben_Rechts =>
                                        ('┗', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskurve_Oben_Links =>
                                        ('┛', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskreuzung_Drei_Oben =>
                                        ('┻', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskreuzung_Drei_Unten =>
                                        ('┳', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskreuzung_Drei_Rechts =>
                                        ('┣', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flusskreuzung_Drei_Links =>
                                        ('┫', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flussendstück_Links =>
                                        ('╺', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flussendstück_Rechts =>
                                        ('╸', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flussendstück_Unten =>
                                        ('╹', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Flussendstück_Oben =>
                                        ('╻', (1 => True, 3 => True, 4 => True, others => False),
                                         1, 0, 1, 0, 1),                                      
                                      GlobaleDatentypen.Fluss_Einzeln =>
                                        ('▪', (1 => True, 3 => True, 4 => True, others => False),
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
                                                         (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                          0, 0, 0, 1, 0),                                      
                                                       GlobaleDatentypen.Wasser =>
                                                         (' ', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                                          1, 0, 1, 1, 0),                                      
                                                       GlobaleDatentypen.Flachland =>
                                                         (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                          2, 1, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Tundra =>
                                                         (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 2, 1, 1, 0),                                      
                                                       GlobaleDatentypen.Wüste =>
                                                         (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                          0, 1, 1, 1, 0),                                      
                                                       -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                                       GlobaleDatentypen.Hügel =>
                                                         (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 2, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Gebirge =>
                                                         (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                          0, 3, 1, 1, 2),
                                                       GlobaleDatentypen.Wald =>
                                                         (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 2, 1, 1, 1),                                      
                                                       GlobaleDatentypen.Dschungel =>
                                                         (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 3, 1, 1, 2),                                      
                                                       GlobaleDatentypen.Küstengewässer =>
                                                         (' ', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                                          2, 0, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Sumpf =>
                                                         (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 1, 1, 1, 2),                                      
                                                       -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
                                                       GlobaleDatentypen.Hügel_Mit =>
                                                         (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Lava =>
                                                         (' ', (7 => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Wolken =>
                                                         (' ', (3 => True, 4 => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Weltraum =>
                                                         (' ', (4 => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Erde =>
                                                         (' ', (6 => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Gestein =>
                                                         (' ', (6 => True, others => False),
                                                          0, 0, 0, 0, 0),                                      
                                                       GlobaleDatentypen.Unter_Wasser =>
                                                         (' ', (5 => True, others => False),
                                                          1, 0, 1, 1, 0),                                      
                                                       GlobaleDatentypen.Unter_Küstengewässer =>
                                                         (' ', (5 => True, others => False),
                                                          2, 0, 1, 0, 0),
                                      
                                                       -- Ressourcen
                                                       GlobaleDatentypen.Kohle =>
                                                         ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                                          0, 2, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Eisen =>
                                                         ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                                          0, 2, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Öl =>
                                                         ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                                          0, 2, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Fisch =>
                                                         ('≈', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                                          2, 0, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Wal =>
                                                         ('≈', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                                          2, 1, 2, 0, 0),                                      
                                                       GlobaleDatentypen.Hochwertiger_Boden =>
                                                         ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                                          2, 1, 1, 0, 0),                                      
                                                       GlobaleDatentypen.Gold =>
                                                         ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                                          0, 1, 3, 0, 0),
                                      
                                                       -- Fluss
                                                       GlobaleDatentypen.Flusskreuzung_Vier =>
                                                         ('╋', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Fluss_Waagrecht =>
                                                         ('━', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Fluss_Senkrecht =>
                                                         ('┃', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskurve_Unten_Rechts =>
                                                         ('┏', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskurve_Unten_Links =>
                                                         ('┓', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskurve_Oben_Rechts =>
                                                         ('┗', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskurve_Oben_Links =>
                                                         ('┛', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskreuzung_Drei_Oben =>
                                                         ('┻', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskreuzung_Drei_Unten =>
                                                         ('┳', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskreuzung_Drei_Rechts =>
                                                         ('┣', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flusskreuzung_Drei_Links =>
                                                         ('┫', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flussendstück_Links =>
                                                         ('╺', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flussendstück_Rechts =>
                                                         ('╸', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flussendstück_Unten =>
                                                         ('╹', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Flussendstück_Oben =>
                                                         ('╻', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1),                                      
                                                       GlobaleDatentypen.Fluss_Einzeln =>
                                                         ('▪', (1 => True, 3 => True, 4 => True, others => False),
                                                          1, 0, 1, 0, 1)
                                                      );

end KartenDatenbank;

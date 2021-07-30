pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package KartenDatenbank is
   
   type KartenListeArray is array (GlobaleDatentypen.Karten_Grund_Enum'Range) of DatenbankRecords.KartenListeRecord;
   KartenListe : KartenListeArray;
   
   procedure StandardKartenDatenbankLaden;   
   
private
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
   
   KartenListeStandard : constant KartenListeArray :=
     (
      -- Nullwert für Ressourcen, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
      GlobaleDatentypen.Leer => GlobaleKonstanten.LeerKartenListe,
                                      
      -- Feld
      GlobaleDatentypen.Eis =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 0, 
         Geldgewinnung       => 0,
         Wissensgewinnung    => 1,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Wasser =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Wasser      => True,
                                 GlobaleDatentypen.Luft        => True,
                                 GlobaleDatentypen.Weltraum    => True,
                                 GlobaleDatentypen.Unterwasser => True,
                                 others                        => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 1,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 1,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Flachland =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 2,
         Ressourcengewinnung => 1,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Tundra =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 2,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 1,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Wüste =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 1,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 1,
         Verteidigungsbonus  => 0),
                                      
      -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
      GlobaleDatentypen.Hügel =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 2,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Gebirge =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 3,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 1,
         Verteidigungsbonus  => 2),
                                      
      GlobaleDatentypen.Wald =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 2,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 1,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Dschungel =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 3,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 1,
         Verteidigungsbonus  => 2),
                                      
      GlobaleDatentypen.Küstengewässer =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Wasser       => True,
                                 GlobaleDatentypen.Luft         => True,
                                 GlobaleDatentypen.Weltraum     => True,
                                 GlobaleDatentypen.Unterwasser  => True,
                                 GlobaleDatentypen.Küstenwasser => True,
                                 others                         => False),
         Nahrungsgewinnung   => 2,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Sumpf =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 1,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 1,
         Verteidigungsbonus  => 2),
                                      
      -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
      GlobaleDatentypen.Hügel_Mit =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 0,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Lava =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Lava => True,
                                 others                 => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 0,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Wolken =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 0,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Weltraum =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 0,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Erde =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Unteridrisch => True,
                                 others                         => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 1,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 1,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Erdgestein =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Unteridrisch => True,
                                 others                         => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 2,
         Geldgewinnung       => 2,
         Wissensgewinnung    => 2,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Gestein =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Planeteninneres => True,
                                 others                            => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 0,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Unter_Wasser =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Unterwasser => True,
                                 others                        => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 1,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Unter_Küstengewässer =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Unterwasser => True,
                                 others                        => False),
         Nahrungsgewinnung   => 2,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      -- Ressourcen
      GlobaleDatentypen.Kohle =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 2,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Eisen =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 2,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Öl =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 2,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Fisch =>
        (KartenGrafik        => '≈',
         Passierbarkeit      => (GlobaleDatentypen.Wasser       => True,
                                 GlobaleDatentypen.Luft         => True,
                                 GlobaleDatentypen.Weltraum     => True,
                                 GlobaleDatentypen.Unterwasser  => True,
                                 GlobaleDatentypen.Küstenwasser => True,
                                 others                         => False),
         Nahrungsgewinnung   => 2,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Wal =>
        (KartenGrafik        => '≈',
         Passierbarkeit      => (GlobaleDatentypen.Wasser       => True,
                                 GlobaleDatentypen.Luft         => True,
                                 GlobaleDatentypen.Weltraum     => True,
                                 GlobaleDatentypen.Unterwasser  => True,
                                 GlobaleDatentypen.Küstenwasser => True,
                                 others                         => False),
         Nahrungsgewinnung   => 2,
         Ressourcengewinnung => 1,
         Geldgewinnung       => 2,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Hochwertiger_Boden =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 2,
         Ressourcengewinnung => 1,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      GlobaleDatentypen.Gold =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 0,
         Ressourcengewinnung => 1,
         Geldgewinnung       => 3,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 0),
                                      
      -- Fluss
      GlobaleDatentypen.Flusskreuzung_Vier =>
        (KartenGrafik        => '╋',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Fluss_Waagrecht =>
        (KartenGrafik        => '━',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Fluss_Senkrecht =>
        (KartenGrafik        => '┃',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flusskurve_Unten_Rechts =>
        (KartenGrafik        => '┏',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flusskurve_Unten_Links =>
        (KartenGrafik        => '┓',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flusskurve_Oben_Rechts =>
        (KartenGrafik        => '┗',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flusskurve_Oben_Links =>
        (KartenGrafik        => '┛',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flusskreuzung_Drei_Oben =>
        (KartenGrafik        => '┻',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flusskreuzung_Drei_Unten =>
        (KartenGrafik        => '┳',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flusskreuzung_Drei_Rechts =>
        (KartenGrafik        => '┣',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others =>                  False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flusskreuzung_Drei_Links =>
        (KartenGrafik        => '┫',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung     => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flussendstück_Links =>
        (KartenGrafik        => '╺',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flussendstück_Rechts =>
        (KartenGrafik        => '╸',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flussendstück_Unten =>
        (KartenGrafik        => '╹',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Flussendstück_Oben =>
        (KartenGrafik        => '╻',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1),
                                      
      GlobaleDatentypen.Fluss_Einzeln =>
        (KartenGrafik        => '▪',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         Nahrungsgewinnung   => 1,
         Ressourcengewinnung => 0,
         Geldgewinnung       => 1,
         Wissensgewinnung    => 0,
         Verteidigungsbonus  => 1)
     );

end KartenDatenbank;

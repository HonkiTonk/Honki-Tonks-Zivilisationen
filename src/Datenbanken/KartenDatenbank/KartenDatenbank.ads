pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package KartenDatenbank is
   
   type KartenListeArray is array (GlobaleDatentypen.Karten_Grund_Enum'Range) of DatenbankRecords.KartenListeRecord;
   KartenListe : KartenListeArray;
   
   procedure StandardKartenDatenbankLaden;   
   
private
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
   -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
   
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
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Wasser =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Wasser      => True,
                                 GlobaleDatentypen.Luft        => True,
                                 GlobaleDatentypen.Weltraum    => True,
                                 others                        => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flachland =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Tundra =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Wüste =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
      GlobaleDatentypen.Hügel =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Gebirge =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Wald =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Dschungel =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Küstengewässer =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Wasser       => True,
                                 GlobaleDatentypen.Luft         => True,
                                 GlobaleDatentypen.Weltraum     => True,
                                 GlobaleDatentypen.Küstenwasser => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Sumpf =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
      GlobaleDatentypen.Hügel_Mit =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Lava =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Lava => True,
                                 others                 => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Wolken =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Weltraum =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Erde =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Erdgestein =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Gestein =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Unter_Wasser =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Unterwasser => True,
                                 others                        => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Unter_Küstengewässer =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (GlobaleDatentypen.Unterwasser => True,
                                 others                        => False),
         FeldWerte           => (others => (others => 1))),
      -- Feld
      
      
                                      
      -- Ressourcen
      -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
      GlobaleDatentypen.Kohle =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Eisen =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Öl =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Fisch =>
        (KartenGrafik        => '≈',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
      
      GlobaleDatentypen.Wal =>
        (KartenGrafik        => '≈',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Hochwertiger_Boden =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Gold =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
      -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
      -- Ressourcen
      
      
                                      
      -- Fluss
      GlobaleDatentypen.Flusskreuzung_Vier =>
        (KartenGrafik        => '╋',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Fluss_Waagrecht =>
        (KartenGrafik        => '━',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Fluss_Senkrecht =>
        (KartenGrafik        => '┃',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flusskurve_Unten_Rechts =>
        (KartenGrafik        => '┏',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flusskurve_Unten_Links =>
        (KartenGrafik        => '┓',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flusskurve_Oben_Rechts =>
        (KartenGrafik        => '┗',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flusskurve_Oben_Links =>
        (KartenGrafik        => '┛',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flusskreuzung_Drei_Oben =>
        (KartenGrafik        => '┻',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flusskreuzung_Drei_Unten =>
        (KartenGrafik        => '┳',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flusskreuzung_Drei_Rechts =>
        (KartenGrafik        => '┣',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others =>                  False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flusskreuzung_Drei_Links =>
        (KartenGrafik        => '┫',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flussendstück_Links =>
        (KartenGrafik        => '╺',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flussendstück_Rechts =>
        (KartenGrafik        => '╸',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flussendstück_Unten =>
        (KartenGrafik        => '╹',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Flussendstück_Oben =>
        (KartenGrafik        => '╻',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      GlobaleDatentypen.Fluss_Einzeln =>
        (KartenGrafik        => '▪',
         Passierbarkeit      => (GlobaleDatentypen.Boden    => True,
                                 GlobaleDatentypen.Luft     => True,
                                 GlobaleDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1)))
      -- Fluss
     );

end KartenDatenbank;

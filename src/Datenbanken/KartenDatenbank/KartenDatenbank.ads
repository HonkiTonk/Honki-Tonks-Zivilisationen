pragma SPARK_Mode (On);

with KartenKonstanten;
with KartenDatentypen;
with EinheitStadtDatentypen;

with DatenbankRecords;

package KartenDatenbank is
   
   type KartenListeArray is array (KartenDatentypen.Karten_Grund_Enum'Range) of DatenbankRecords.KartenListeRecord;
   KartenListe : KartenListeArray;
   
   procedure StandardKartenDatenbankLaden;
   
private
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
   -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
   
   KartenListeStandard : constant KartenListeArray :=
     (
      -- Nullwert für Ressourcen, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
      KartenDatentypen.Leer => KartenKonstanten.LeerKartenListe,
                                      
      -- Feld
      -- Normal
      KartenDatentypen.Eis =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Wasser =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Wasser      => True,
                                 EinheitStadtDatentypen.Luft        => True,
                                 EinheitStadtDatentypen.Weltraum    => True,
                                 others                        => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flachland =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Tundra =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Wüste =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
      KartenDatentypen.Hügel =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Gebirge =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Wald =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Dschungel =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Küstengewässer =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Wasser       => True,
                                 EinheitStadtDatentypen.Luft         => True,
                                 EinheitStadtDatentypen.Weltraum     => True,
                                 EinheitStadtDatentypen.Küstenwasser => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Sumpf =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
      KartenDatentypen.Hügel_Mit =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
      -- Normal
      
      
      
      -- Unterwasser/Unterirdisch
      KartenDatentypen.Unterwasser_Eis =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Erde =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
      
      KartenDatentypen.Erdgestein =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
      
      KartenDatentypen.Sand =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
      
      KartenDatentypen.Unterwasser_Wasser =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterwasser => True,
                                 others                        => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterwasser_Küstengewässer =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterwasser => True,
                                 others                        => False),
         FeldWerte           => (others => (others => 1))),
      
      KartenDatentypen.Korallen =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterwasser => True,
                                 others                        => False),
         FeldWerte           => (others => (others => 1))),
      
      KartenDatentypen.Unterwasser_Wald =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterwasser => True,
                                 others                        => False),
         FeldWerte           => (others => (others => 1))),
      -- Unterwasser/Unterirdisch
      
      
                   
      -- Planeteninneres
      KartenDatentypen.Lava =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                 => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Gestein =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
      
      KartenDatentypen.Planetenkern =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                 => False),
         FeldWerte           => (others => (others => 1))),
      -- Planeteninneres
      
      
      
      -- Luft/Weltraum
      KartenDatentypen.Wolken =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Weltraum =>
        (KartenGrafik        => ' ',
         Passierbarkeit      => (EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
      -- Luft/Weltraum
      -- Feld
      
      
                                      
      -- Ressourcen
      -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
      KartenDatentypen.Kohle =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Eisen =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Öl =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Fisch =>
        (KartenGrafik        => '≈',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
      
      KartenDatentypen.Wal =>
        (KartenGrafik        => '≈',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Hochwertiger_Boden =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Gold =>
        (KartenGrafik        => '♦',
         Passierbarkeit      => (others => False),
         FeldWerte           => (others => (others => 1))),
      -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
      -- Ressourcen
      
      
      
      -- Flüsss
      -- Normal
        KartenDatentypen.Flusskreuzung_Vier =>
          (KartenGrafik        => '╋',
           Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                   EinheitStadtDatentypen.Luft     => True,
                                   EinheitStadtDatentypen.Weltraum => True,
                                   others                     => False),
           FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Fluss_Waagrecht =>
        (KartenGrafik        => '━',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Fluss_Senkrecht =>
        (KartenGrafik        => '┃',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flusskurve_Unten_Rechts =>
        (KartenGrafik        => '┏',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flusskurve_Unten_Links =>
        (KartenGrafik        => '┓',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flusskurve_Oben_Rechts =>
        (KartenGrafik        => '┗',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flusskurve_Oben_Links =>
        (KartenGrafik        => '┛',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flusskreuzung_Drei_Oben =>
        (KartenGrafik        => '┻',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flusskreuzung_Drei_Unten =>
        (KartenGrafik        => '┳',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flusskreuzung_Drei_Rechts =>
        (KartenGrafik        => '┣',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others =>                  False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flusskreuzung_Drei_Links =>
        (KartenGrafik        => '┫',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flussendstück_Links =>
        (KartenGrafik        => '╺',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flussendstück_Rechts =>
        (KartenGrafik        => '╸',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flussendstück_Unten =>
        (KartenGrafik        => '╹',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Flussendstück_Oben =>
        (KartenGrafik        => '╻',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Fluss_Einzeln =>
        (KartenGrafik        => '▪',
         Passierbarkeit      => (EinheitStadtDatentypen.Boden    => True,
                                 EinheitStadtDatentypen.Luft     => True,
                                 EinheitStadtDatentypen.Weltraum => True,
                                 others                     => False),
         FeldWerte           => (others => (others => 1))),
      -- Normal
      
      
      
      -- Unterirdisch
      KartenDatentypen.Unterirdische_Flusskreuzung_Vier =>
        (KartenGrafik        => '╋',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdischer_Fluss_Waagrecht =>
        (KartenGrafik        => '━',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdischer_Fluss_Senkrecht =>
        (KartenGrafik        => '┃',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdische_Flusskurve_Unten_Rechts =>
        (KartenGrafik        => '┏',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdische_Flusskurve_Unten_Links =>
        (KartenGrafik        => '┓',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdische_Flusskurve_Oben_Rechts =>
        (KartenGrafik        => '┗',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdische_Flusskurve_Oben_Links =>
        (KartenGrafik        => '┛',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Oben =>
        (KartenGrafik        => '┻',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Unten =>
        (KartenGrafik        => '┳',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Rechts =>
        (KartenGrafik        => '┣',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Links =>
        (KartenGrafik        => '┫',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdisches_Flussendstück_Links =>
        (KartenGrafik        => '╺',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdisches_Flussendstück_Rechts =>
        (KartenGrafik        => '╸',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdisches_Flussendstück_Unten =>
        (KartenGrafik        => '╹',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdisches_Flussendstück_Oben =>
        (KartenGrafik        => '╻',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Unterirdischer_Fluss_Einzeln =>
        (KartenGrafik        => '▪',
         Passierbarkeit      => (EinheitStadtDatentypen.Unterirdisch => True,
                                 others                         => False),
         FeldWerte           => (others => (others => 1))),
      -- Unterirdisch
      
      
      
      -- Lava
      KartenDatentypen.Lavaflusskreuzung_Vier =>
        (KartenGrafik        => '╋',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavafluss_Waagrecht =>
        (KartenGrafik        => '━',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavafluss_Senkrecht =>
        (KartenGrafik        => '┃',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflusskurve_Unten_Rechts =>
        (KartenGrafik        => '┏',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflusskurve_Unten_Links =>
        (KartenGrafik        => '┓',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflusskurve_Oben_Rechts =>
        (KartenGrafik        => '┗',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflusskurve_Oben_Links =>
        (KartenGrafik        => '┛',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflusskreuzung_Drei_Oben =>
        (KartenGrafik        => '┻',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflusskreuzung_Drei_Unten =>
        (KartenGrafik        => '┳',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflusskreuzung_Drei_Rechts =>
        (KartenGrafik        => '┣',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflusskreuzung_Drei_Links =>
        (KartenGrafik        => '┫',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflussendstück_Links =>
        (KartenGrafik        => '╺',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflussendstück_Rechts =>
        (KartenGrafik        => '╸',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflussendstück_Unten =>
        (KartenGrafik        => '╹',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavaflussendstück_Oben =>
        (KartenGrafik        => '╻',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1))),
                                      
      KartenDatentypen.Lavafluss_Einzeln =>
        (KartenGrafik        => '▪',
         Passierbarkeit      => (EinheitStadtDatentypen.Planeteninneres => True,
                                 others                            => False),
         FeldWerte           => (others => (others => 1)))
      -- Lava
      -- Flüsss
      
      -- others                 => GlobaleKonstanten.LeerKartenListe
     );

end KartenDatenbank;

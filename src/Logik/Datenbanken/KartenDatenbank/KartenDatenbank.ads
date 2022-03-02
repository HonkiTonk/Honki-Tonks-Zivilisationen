pragma SPARK_Mode (On);

with KartenDatentypen;
with EinheitStadtDatentypen;
with KartenGrundKonstanten;
with KartenRecordKonstanten;

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
      KartenGrundKonstanten.LeerGrund => KartenRecordKonstanten.LeerKartenListe,
                                      
      -- Feld
      -- Normal
      KartenGrundKonstanten.EisKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
     
      KartenGrundKonstanten.WasserKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Wasser      => True,
                            EinheitStadtDatentypen.Luft        => True,
                            EinheitStadtDatentypen.Weltraum    => True,
                            others                             => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlachlandKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.TundraKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.WüsteKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
      KartenGrundKonstanten.HügelKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.GebirgeKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.WaldKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.DschungelKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.KüstengewässerKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Wasser       => True,
                            EinheitStadtDatentypen.Luft         => True,
                            EinheitStadtDatentypen.Weltraum     => True,
                            EinheitStadtDatentypen.Küstenwasser => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.SumpfKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
      KartenGrundKonstanten.HügelMitKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Normal
      
      
      
      -- Unterwasser/Unterirdisch
      KartenGrundKonstanten.UnterwasserEisKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.ErdeKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.ErdgesteinKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.SandKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.UnterwasserWasserKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Unterwasser => True,
                            others                             => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterwasserKüstengewässerKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Unterwasser => True,
                            others                             => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.KorallenKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Unterwasser => True,
                            others                             => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.UnterwasserWaldKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Unterwasser => True,
                            others                             => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Unterwasser/Unterirdisch
      
      
                   
      -- Planeteninneres
      KartenGrundKonstanten.LavaKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.GesteinKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.PlanetenkernKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Planeteninneres
      
      
      
      -- Luft/Weltraum
      KartenGrundKonstanten.WolkenKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.WeltraumKonstante =>
        (KartenGrafik   => ' ',
         Passierbarkeit => (EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Luft/Weltraum
      -- Feld
      
      
                                      
      -- Ressourcen
      -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
      KartenGrundKonstanten.KohleKonstante =>
        (KartenGrafik   => '♦',
         Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.EisenKonstante =>
        (KartenGrafik   => '♦',
         Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.ÖlKonstante =>
        (KartenGrafik   => '♦',
         Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FischKonstante =>
        (KartenGrafik   => '≈',
         Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.WalKonstante =>
        (KartenGrafik   => '≈',
         Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.HochwertigerBodenKonstante =>
        (KartenGrafik   => '♦',
         Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.GoldKonstante =>
        (KartenGrafik   => '♦',
         Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
      -- Ressourcen
      
      
      
      -- Flüsse
      -- Normal
      KartenGrundKonstanten.FlusskreuzungVierKonstante =>
        (KartenGrafik   => '╋',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussWaagrechtKonstante =>
        (KartenGrafik   => '━',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussSenkrechtKonstante =>
        (KartenGrafik   => '┃',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskurveUntenRechtsKonstante =>
        (KartenGrafik   => '┏',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskurveUntenLinksKonstante =>
        (KartenGrafik   => '┓',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskurveObenRechtsKonstante =>
        (KartenGrafik   => '┗',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskurveObenLinksKonstante =>
        (KartenGrafik   => '┛',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskreuzungDreiObenKonstante =>
        (KartenGrafik   => '┻',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskreuzungDreiUntenKonstante =>
        (KartenGrafik   => '┳',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskreuzungDreiRechtsKonstante =>
        (KartenGrafik   => '┣',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskreuzungDreiLinksKonstante =>
        (KartenGrafik   => '┫',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussendstückLinksKonstante =>
        (KartenGrafik   => '╺',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussendstückRechtsKonstante =>
        (KartenGrafik   => '╸',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussendstückUntenKonstante =>
        (KartenGrafik   => '╹',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussendstückObenKonstante =>
        (KartenGrafik   => '╻',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.SeeKonstante =>
        (KartenGrafik   => '▪',
         Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Normal
      
      
      
      -- Unterirdisch
      KartenGrundKonstanten.UnterirdischeFlusskreuzungVierKonstante =>
        (KartenGrafik   => '╋',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischerFlussWaagrechtKonstante =>
        (KartenGrafik   => '━',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischerFlussSenkrechtKonstante =>
        (KartenGrafik   => '┃',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskurveUntenRechtsKonstante =>
        (KartenGrafik   => '┏',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskurveUntenLinksKonstante =>
        (KartenGrafik   => '┓',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskurveObenRechtsKonstante =>
        (KartenGrafik   => '┗',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskurveObenLinksKonstante =>
        (KartenGrafik   => '┛',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiObenKonstante =>
        (KartenGrafik   => '┻',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiUntenKonstante =>
        (KartenGrafik   => '┳',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiRechtsKonstante =>
        (KartenGrafik   => '┣',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiLinksKonstante =>
        (KartenGrafik   => '┫',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischesFlussendstückLinksKonstante =>
        (KartenGrafik   => '╺',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischesFlussendstückRechtsKonstante =>
        (KartenGrafik   => '╸',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischesFlussendstückUntenKonstante =>
        (KartenGrafik   => '╹',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischesFlussendstückObenKonstante =>
        (KartenGrafik   => '╻',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischerSeeKonstante =>
        (KartenGrafik   => '▪',
         Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Unterirdisch
      
      
      
      -- Lava
      KartenGrundKonstanten.LavaflusskreuzungVierKonstante =>
        (KartenGrafik   => '╋',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussWaagrechtKonstante =>
        (KartenGrafik   => '━',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussSenkrechtKonstante =>
        (KartenGrafik   => '┃',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskurveUntenRechtsKonstante =>
        (KartenGrafik   => '┏',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskurveUntenLinksKonstante =>
        (KartenGrafik   => '┓',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskurveObenRechtsKonstante =>
        (KartenGrafik   => '┗',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskurveObenLinksKonstante =>
        (KartenGrafik   => '┛',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskreuzungDreiObenKonstante =>
        (KartenGrafik   => '┻',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskreuzungDreiUntenKonstante =>
        (KartenGrafik   => '┳',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskreuzungDreiRechtsKonstante =>
        (KartenGrafik   => '┣',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskreuzungDreiLinksKonstante =>
        (KartenGrafik   => '┫',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussendstückLinksKonstante =>
        (KartenGrafik   => '╺',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussendstückRechtsKonstante =>
        (KartenGrafik   => '╸',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussendstückUntenKonstante =>
        (KartenGrafik   => '╹',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussendstückObenKonstante =>
        (KartenGrafik   => '╻',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaseeKonstante =>
        (KartenGrafik   => '▪',
         Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1)))
      -- Lava
      -- Flüsse
      
      -- others                 => GlobaleKonstanten.LeerKartenListe
     );

end KartenDatenbank;

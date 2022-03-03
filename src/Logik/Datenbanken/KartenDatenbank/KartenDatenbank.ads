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
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
     
      KartenGrundKonstanten.WasserKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Wasser      => True,
                            EinheitStadtDatentypen.Luft        => True,
                            EinheitStadtDatentypen.Weltraum    => True,
                            others                             => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlachlandKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.TundraKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.WüsteKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
      KartenGrundKonstanten.HügelKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.GebirgeKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.WaldKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.DschungelKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.KüstengewässerKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Wasser       => True,
                            EinheitStadtDatentypen.Luft         => True,
                            EinheitStadtDatentypen.Weltraum     => True,
                            EinheitStadtDatentypen.Küstenwasser => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.SumpfKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
      KartenGrundKonstanten.HügelMitKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Normal
      
      
      
      -- Unterwasser/Unterirdisch
      KartenGrundKonstanten.UnterwasserEisKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.ErdeKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.ErdgesteinKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.SandKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.UnterwasserWasserKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterwasser => True,
                            others                             => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterwasserKüstengewässerKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterwasser => True,
                            others                             => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.KorallenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterwasser => True,
                            others                             => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.UnterwasserWaldKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterwasser => True,
                            others                             => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Unterwasser/Unterirdisch
      
      
                   
      -- Planeteninneres
      KartenGrundKonstanten.LavaKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.GesteinKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.PlanetenkernKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Planeteninneres
      
      
      
      -- Luft/Weltraum
      KartenGrundKonstanten.WolkenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.WeltraumKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Luft/Weltraum
      -- Feld
      
      
                                      
      -- Ressourcen
      -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
      KartenGrundKonstanten.KohleKonstante =>
        (Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.EisenKonstante =>
        (Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.ÖlKonstante =>
        (Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FischKonstante =>
        (Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      
      KartenGrundKonstanten.WalKonstante =>
        (Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.HochwertigerBodenKonstante =>
        (Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.GoldKonstante =>
        (Passierbarkeit => (others => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
      -- Ressourcen
      
      
      
      -- Flüsse
      -- Normal
      KartenGrundKonstanten.FlusskreuzungVierKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussWaagrechtKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussSenkrechtKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskurveUntenRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskurveUntenLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskurveObenRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskurveObenLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskreuzungDreiObenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskreuzungDreiUntenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskreuzungDreiRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlusskreuzungDreiLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussendstückLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussendstückRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussendstückUntenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.FlussendstückObenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.SeeKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Boden    => True,
                            EinheitStadtDatentypen.Luft     => True,
                            EinheitStadtDatentypen.Weltraum => True,
                            others                          => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Normal
      
      
      
      -- Unterirdisch
      KartenGrundKonstanten.UnterirdischeFlusskreuzungVierKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischerFlussWaagrechtKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischerFlussSenkrechtKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskurveUntenRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskurveUntenLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskurveObenRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskurveObenLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiObenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiUntenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischeFlusskreuzungDreiLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischesFlussendstückLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischesFlussendstückRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischesFlussendstückUntenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischesFlussendstückObenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.UnterirdischerSeeKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch => True,
                            others                              => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
      -- Unterirdisch
      
      
      
      -- Lava
      KartenGrundKonstanten.LavaflusskreuzungVierKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussWaagrechtKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussSenkrechtKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskurveUntenRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskurveUntenLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskurveObenRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskurveObenLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskreuzungDreiObenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskreuzungDreiUntenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskreuzungDreiRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflusskreuzungDreiLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussendstückLinksKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussendstückRechtsKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussendstückUntenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaflussendstückObenKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1))),
                                      
      KartenGrundKonstanten.LavaseeKonstante =>
        (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres => True,
                            others                                 => False),
         Bewertung      => (others => 1),
         Wirtschaft     => (others => (others => 1)),
         Kampf          => (others => (others => 1)))
      -- Lava
      -- Flüsse
      
      -- others                 => GlobaleKonstanten.LeerKartenListe
     );

end KartenDatenbank;

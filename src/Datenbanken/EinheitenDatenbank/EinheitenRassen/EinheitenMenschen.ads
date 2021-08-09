pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten, GlobaleRecords;

with DatenbankRecords;

package EinheitenMenschen is
   
   EinheitenMenschenListe : constant DatenbankRecords.EinheitenListeArray :=
     (
      -- Steinzeitsiedler
      1 =>
        (EinheitenGrafik         => 'S',
         EinheitArt              => GlobaleDatentypen.Arbeiter,
         PreisGeld               => 10,
         PreisRessourcen         => 10,
         PermanenteKosten        => (others => 0),
         Anforderungen           => 0,
         Passierbarkeit          => (GlobaleDatentypen.Boden => True,
                                     others                  => False),
         MaximaleLebenspunkte    => 3,
         MaximaleBewegungspunkte => 3.00,
         WirdVerbessertZu        => 0,
         Beförderungsgrenze      => 30,
         MaximalerRang           => 3,
         Reichweite              => 1,
         Angriff                 => 0,
         Verteidigung            => 1,
         KannTransportieren      => 0,
         KannTransportiertWerden => 1,
         Transportkapazität      => 0),
                                               
      -- Steinzeitkämpfer
      2 =>
        (EinheitenGrafik         => 'F',
         EinheitArt              => GlobaleDatentypen.Nahkämpfer,
         PreisGeld               => 25,
         PreisRessourcen         => 20,
         PermanenteKosten        => (others => 0),
         Anforderungen           => 0,
         Passierbarkeit          => (GlobaleDatentypen.Boden => True,
                                     others                  => False),
         MaximaleLebenspunkte    => 5,
         MaximaleBewegungspunkte => 3.00,
         WirdVerbessertZu        => 0,
         Beförderungsgrenze      => 30,
         MaximalerRang           => 3,
         Reichweite              => 1,
         Angriff                 => 3,
         Verteidigung            => 1,
         KannTransportieren      => 0,
         KannTransportiertWerden => 1,
         Transportkapazität      => 0),
                                               
      -- Bogenschütze
      3 =>
        (EinheitenGrafik         => 'N',
         EinheitArt              => GlobaleDatentypen.Fernkämpfer,
         PreisGeld               => 25,
         PreisRessourcen         => 20,
         PermanenteKosten        => (others => 0),
         Anforderungen           => 1,
         Passierbarkeit          => (GlobaleDatentypen.Boden => True,
                                     others                  => False),
         MaximaleLebenspunkte    => 5,
         MaximaleBewegungspunkte => 3.00,
         WirdVerbessertZu        => 4,
         Beförderungsgrenze      => 30,
         MaximalerRang           => 3,
         Reichweite              => 2,
         Angriff                 => 3,
         Verteidigung            => 1,
         KannTransportieren      => 0,
         KannTransportiertWerden => 1,
         Transportkapazität      => 0),
      
      -- Erstes Schiff
      4 =>
        (EinheitenGrafik         => 'W',
         EinheitArt              => GlobaleDatentypen.Nahkämpfer,
         PreisGeld               => 25,
         PreisRessourcen         => 20,
         PermanenteKosten        => (others => 0),
         Anforderungen           => 7,
         Passierbarkeit          => (GlobaleDatentypen.Wasser       => True,
                                     -- Für das erste Schiff keine Wasserpassierbarkeit?
                                     GlobaleDatentypen.Küstenwasser => True,
                                     others                         => False),
         MaximaleLebenspunkte    => 5,
         MaximaleBewegungspunkte => 3.00,
         WirdVerbessertZu        => 4,
         Beförderungsgrenze      => 30,
         MaximalerRang           => 3,
         Reichweite              => 2,
         Angriff                 => 3,
         Verteidigung            => 1,
         KannTransportieren      => 0,
         KannTransportiertWerden => 1,
         Transportkapazität      => 0),
                                               
      -- Alleskönner
      49 =>
        (EinheitenGrafik         => 'A',
         EinheitArt              => GlobaleDatentypen.Beides,
         PreisGeld               => 1,
         PreisRessourcen         => 1,
         PermanenteKosten        => (others => 0),
         Anforderungen           => 0,
         Passierbarkeit          => (others => True),
         MaximaleLebenspunkte    => 100,
         MaximaleBewegungspunkte => 100.00,
         WirdVerbessertZu        => 0,
         Beförderungsgrenze      => 1,
         MaximalerRang           => 100,
         Reichweite              => 100,
         Angriff                 => 100,
         Verteidigung            => 100,
         KannTransportieren      => 10,
         KannTransportiertWerden => 0,
         Transportkapazität      => GlobaleRecords.TransporterArray'Last),
                                                               
      others => GlobaleKonstanten.LeerEinheitListe
     );

end EinheitenMenschen;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen;
with EinheitenRecordKonstanten;
with EinheitenRecords;

with DatenbankRecords;

-- Es muss darauf geachtet werden dass KannTransportieren immer kleiner ist als KannTransportiertWerden.
package EinheitenTalbidahr is

   EinheitenlisteTalbidahr : constant DatenbankRecords.EinheitenlisteArray := (
                                                                               -- Siedler
                                                                               1 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Arbeiter_Enum,
                                                                                  PreisGeld               => 10,
                                                                                  PreisRessourcen         => 10,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 0,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 3,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 1,
                                                                                  Angriff                 => 0,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Steinzeitkämpfer
                                                                               2 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 0,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 5,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 1,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Bogenschütze
                                                                               3 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 1,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 8,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
      
                                                                                 -- Erstes Schiff
                                                                               4 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 7,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 10,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Bronzekämpfer
                                                                               5 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 10,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 6,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Eisenkämpfer
                                                                               6 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 13,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 12,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Streitwagen
                                                                               7 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 5,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 17,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Katapult
                                                                               8 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 11,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 9,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Balliste
                                                                               9 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 12,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 13,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Segelschiff
                                                                               10 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 14,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 11,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Großes Segelschiff
                                                                               11 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 23,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 14,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Gewehrkämpfer
                                                                               12 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 28,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 44,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Kanone
                                                                               13 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 34,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 40,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Dampfschiff
                                                                               14 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 31,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 15,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Motorschiff
                                                                               15 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 38,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 42,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- U-Boot
                                                                               16 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 39,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                              EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                              others                                        => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 42,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Gepanzerter Wagen
                                                                               17 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 40,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 18,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Panzer
                                                                               18 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 42,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 35,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Jäger
                                                                               19 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 41,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Luft_Enum => True,
                                                                                                              others                           => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 22,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Bomber
                                                                               20 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 41,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Luft_Enum => True,
                                                                                                              others                           => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 23,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Rakete
                                                                               21 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 46,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                                              EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                              others                               => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Düsenjäger
                                                                               22 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 51,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Luft_Enum => True,
                                                                                                              others                           => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 38,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Düsenbomber
                                                                               23 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 51,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Luft_Enum => True,
                                                                                                              others                           => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 39,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Atombombe
                                                                               24 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 45,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                              others                            => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Drohne
                                                                               25 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 49,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Luft_Enum => True,
                                                                                                              others                           => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Gensoldat
                                                                               26 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 56,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 28,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Wassersiedler
                                                                               27 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Arbeiter_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 58,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum        => True,
                                                                                                              EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Cyborg
                                                                               28 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 57,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 33,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Unterwasser/Unterirdischer Siedler
                                                                               29 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Arbeiter_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 62,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum             => True,
                                                                                                              EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                              EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                              EinheitenDatentypen.Unterirdisch_Enum      => True,
                                                                                                              others                                        => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- PZB20
                                                                               30 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Sonstiges_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 63,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                              others                            => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- PZB40
                                                                               31 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Sonstiges_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 66,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                              others                            => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- PZB100
                                                                               32 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Sonstiges_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 66,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                              others                            => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Gaußkämpfer
                                                                               33 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 68,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 34,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Magnetkämpfer
                                                                               34 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 74,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Schwebepanzer
                                                                               35 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 74,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum        => True,
                                                                                                              EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                              EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Planetenkernsiedler
                                                                               36 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Arbeiter_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 65,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum             => True,
                                                                                                              EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                              EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                              EinheitenDatentypen.Unterirdisch_Enum      => True,
                                                                                                              EinheitenDatentypen.Lava_Enum              => True,
                                                                                                              EinheitenDatentypen.Planeteninneres_Enum   => True,
                                                                                                              others                                        => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Himmel/Orbitalsiedler
                                                                               37 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Arbeiter_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 72,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum        => True,
                                                                                                              EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                              EinheitenDatentypen.Luft_Enum         => True,
                                                                                                              EinheitenDatentypen.Weltraum_Enum     => True,
                                                                                                              EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Atmosphärenjäger
                                                                               38 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 74,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                                              EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                              others                               => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Atmosphärenbomber
                                                                               39 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 74,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                                              EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                              others                               => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Artillerie
                                                                               40 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 42,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 41,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Stellare Artillerie
                                                                               41 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 74,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum        => True,
                                                                                                              EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Gräberschiff
                                                                               42 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 62,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum             => True,
                                                                                                              EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                              EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                              EinheitenDatentypen.Unterirdisch_Enum      => True,
                                                                                                              others                                        => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 43,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Kerngräber
                                                                               43 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 65,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Boden_Enum             => True,
                                                                                                              EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                              EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                              EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                              EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                              EinheitenDatentypen.Unterirdisch_Enum      => True,
                                                                                                              EinheitenDatentypen.Lava_Enum              => True,
                                                                                                              EinheitenDatentypen.Planeteninneres_Enum   => True,
                                                                                                              others                                        => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 0,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Moderne Infanterie
                                                                               44 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                  PreisGeld               => 25,
                                                                                  PreisRessourcen         => 20,
                                                                                  PermanenteKosten        => (others => 0),
                                                                                  Anforderungen           => 40,
                                                                                  Passierbarkeit          => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                              others                                   => False),
                                                                                  MaximaleLebenspunkte    => 5,
                                                                                  MaximaleBewegungspunkte => 3.00,
                                                                                  WirdVerbessertZu        => 26,
                                                                                  Beförderungsgrenze      => 30,
                                                                                  MaximalerRang           => 3,
                                                                                  Reichweite              => 2,
                                                                                  Angriff                 => 3,
                                                                                  Verteidigung            => 1,
                                                                                  KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => 0
                                                                                 ),
                                               
                                                                                 -- Alleskönner
                                                                               45 =>
                                                                                 (
                                                                                  EinheitArt              => EinheitenDatentypen.Cheat_Enum,
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
                                                                                  KannTransportieren      => EinheitenDatentypen.Gigantisch_Transport_Enum,
                                                                                  KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                  Transportkapazität      => EinheitenRecords.TransporterArray'Last
                                                                                 ),
                                                               
                                                                               others => EinheitenRecordKonstanten.LeerEinheitListe
                                                                              );

end EinheitenTalbidahr;
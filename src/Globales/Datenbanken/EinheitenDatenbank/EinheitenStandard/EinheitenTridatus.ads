with EinheitenDatentypen;
with EinheitenRecordKonstanten;
with EinheitendatenbankRecord;
with KartenDatentypen;
with KartenRecordKonstanten;
with KartengrundDatentypen;

with DebugobjekteLogik;

-- Es muss darauf geachtet werden dass KannTransportieren immer kleiner ist als KannTransportiertWerden.
package EinheitenTridatus is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   EinheitenlisteTridatus : constant EinheitendatenbankRecord.EinheitenlisteArray := (
                                                                                      -- Siedler
                                                                                      1 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Arbeiter_Enum,
                                                                                         PreisGeld               => 10,
                                                                                         Produktionskosten       => 10,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 0,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 3,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 1,
                                                                                         Angriff                 => 0,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Steinzeitkämpfer
                                                                                      2 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 0,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 5,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 1,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Bogenschütze
                                                                                      3 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 1,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 8,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
      
                                                                                        -- Erstes Schiff
                                                                                      4 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 7,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                                     others                                => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 10,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 1,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Bronzekämpfer
                                                                                      5 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 10,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 6,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Eisenkämpfer
                                                                                      6 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 13,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 12,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Streitwagen
                                                                                      7 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 5,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 17,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Katapult
                                                                                      8 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 11,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 9,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Balliste
                                                                                      9 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 12,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 13,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Segelschiff
                                                                                      10 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 14,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                                     others                                => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 11,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Groß_Transport_Enum,
                                                                                         Transportkapazität      => 2,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Großes Segelschiff
                                                                                      11 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 23,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                                     others                                => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 14,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Gigantisch_Transport_Enum,
                                                                                         Transportkapazität      => 4,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Gewehrkämpfer
                                                                                      12 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 28,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 44,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Kanone
                                                                                      13 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 34,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 40,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Dampfschiff
                                                                                      14 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 31,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                                     others                                => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 15,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Gigantisch_Transport_Enum,
                                                                                         Transportkapazität      => 4,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Motorschiff
                                                                                      15 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 38,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                                     others                                => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 42,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Gigantisch_Transport_Enum,
                                                                                         Transportkapazität      => 4,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- U-Boot
                                                                                      16 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 39,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     others                                     => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 42,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         Transportkapazität      => 2,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Gepanzerter Wagen
                                                                                      17 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 40,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 18,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Panzer
                                                                                      18 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 42,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 35,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Jäger
                                                                                      19 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 41,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Luft_Enum => True,
                                                                                                                     others                        => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 22,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Groß_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Bomber
                                                                                      20 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 41,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Luft_Enum => True,
                                                                                                                     others                        => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 23,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Groß_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Rakete
                                                                                      21 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 46,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                                     others                            => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Düsenjäger
                                                                                      22 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 51,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Luft_Enum => True,
                                                                                                                     others                        => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 38,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Groß_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Düsenbomber
                                                                                      23 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 51,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Luft_Enum => True,
                                                                                                                     others                        => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 39,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Groß_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Atombombe
                                                                                      24 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 45,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Groß_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Drohne
                                                                                      25 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 49,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Luft_Enum => True,
                                                                                                                     others                        => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Gensoldat
                                                                                      26 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 56,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 28,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Wassersiedler
                                                                                      27 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Arbeiter_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 58,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum        => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                                     others                                => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Cyborg
                                                                                      28 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 57,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 33,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Unterwasser/Unterirdischer Siedler
                                                                                      29 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Arbeiter_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 62,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum             => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Unterirdisch_Enum      => True,
                                                                                                                     others                                     => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- PZB200
                                                                                      30 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Einmalig_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 63,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Gigantisch_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (KartengrundDatentypen.Vernichtet_Enum => True,
                                                                                                                     others                                => False),
                                                                                         Effektreichweite        => (
                                                                                                                     EAchseAnfang => KartenDatentypen.EbeneVorhanden'First,
                                                                                                                     EAchseEnde   => KartenDatentypen.EbeneVorhanden'Last,
                                                                                                                     YAchseAnfang => -100,
                                                                                                                     YAchseEnde   => 100,
                                                                                                                     XAchseAnfang => -100,
                                                                                                                     XAchseEnde   => 100
                                                                                                                    )
                                                                                        ),
                                               
                                                                                        -- PZB400
                                                                                      31 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Einmalig_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 66,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Gigantisch_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (KartengrundDatentypen.Vernichtet_Enum => True,
                                                                                                                     others                                => False),
                                                                                         Effektreichweite        => (
                                                                                                                     EAchseAnfang => KartenDatentypen.EbeneVorhanden'First,
                                                                                                                     EAchseEnde   => KartenDatentypen.EbeneVorhanden'Last,
                                                                                                                     YAchseAnfang => -200,
                                                                                                                     YAchseEnde   => 200,
                                                                                                                     XAchseAnfang => -200,
                                                                                                                     XAchseEnde   => 200
                                                                                                                    )
                                                                                        ),
                                               
                                                                                        -- PZB1000
                                                                                      32 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Einmalig_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 66,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Gigantisch_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (KartengrundDatentypen.Vernichtet_Enum => True,
                                                                                                                     others                                => False),
                                                                                         Effektreichweite        => (
                                                                                                                     EAchseAnfang => KartenDatentypen.EbeneVorhanden'First,
                                                                                                                     EAchseEnde   => KartenDatentypen.EbeneVorhanden'Last,
                                                                                                                     YAchseAnfang => KartenDatentypen.Kartenfeld'First,
                                                                                                                     YAchseEnde   => KartenDatentypen.Kartenfeld'Last,
                                                                                                                     XAchseAnfang => KartenDatentypen.Kartenfeld'First,
                                                                                                                     XAchseEnde   => KartenDatentypen.Kartenfeld'Last
                                                                                                                    )
                                                                                        ),
                                               
                                                                                        -- Gaußkämpfer
                                                                                      33 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 68,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 34,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Magnetkämpfer
                                                                                      34 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 74,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Schwebepanzer
                                                                                      35 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 74,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum        => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                                     others                                => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Planetenkernsiedler
                                                                                      36 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Arbeiter_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
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
                                                                                                                     others                                     => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Himmel/Orbitalsiedler
                                                                                      37 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Arbeiter_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 72,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum        => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Luft_Enum         => True,
                                                                                                                     EinheitenDatentypen.Weltraum_Enum     => True,
                                                                                                                     others                                => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Atmosphärenjäger
                                                                                      38 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 74,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                                     others                            => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Groß_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Atmosphärenbomber
                                                                                      39 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 74,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                                     others                            => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Groß_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Artillerie
                                                                                      40 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 42,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 41,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Stellare Artillerie
                                                                                      41 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 74,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum        => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                                     others                                => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Mittel_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Gräberschiff
                                                                                      42 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 62,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum             => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Unterirdisch_Enum      => True,
                                                                                                                     others                                     => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 43,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Groß_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         Transportkapazität      => 4,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Kerngräber
                                                                                      43 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
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
                                                                                                                     others                                     => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 0,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         Transportkapazität      => 1,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Moderne Infanterie
                                                                                      44 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 40,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum => True,
                                                                                                                     others                         => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 26,
                                                                                         Beförderungsgrenze      => 30,
                                                                                         MaximalerRang           => 3,
                                                                                         Reichweite              => 2,
                                                                                         Angriff                 => 3,
                                                                                         Verteidigung            => 1,
                                                                                         KannTransportieren      => EinheitenDatentypen.Kein_Transport_Enum,
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                                                              
                                                                                      EinheitendatenbankRecord.EinheitenlisteArray'Last => DebugobjekteLogik.Alleskönner,
                                                               
                                                                                      others => EinheitenRecordKonstanten.LeerEinheitListe
                                                                                     );

end EinheitenTridatus;

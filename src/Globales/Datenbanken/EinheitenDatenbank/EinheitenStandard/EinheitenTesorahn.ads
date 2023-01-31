with EinheitenDatentypen;
with EinheitenRecordKonstanten;
with EinheitendatenbankRecord;
with KartenDatentypen;
with KartenRecordKonstanten;
with KartengrundDatentypen;

with DebugobjekteLogik;

-- Es muss darauf geachtet werden dass KannTransportieren immer kleiner ist als KannTransportiertWerden.
package EinheitenTesorahn is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   -- Unterwasser
   EinheitenlisteTesorahn : constant EinheitendatenbankRecord.EinheitenlisteArray := (
                                                                                      -- Siedler
                                                                                      1 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Arbeiter_Enum,
                                                                                         PreisGeld               => 10,
                                                                                         Produktionskosten       => 10,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 0,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     others                                     => False),
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
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     others                                     => False),
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
                                               
                                                                                        -- Knochenkämpfer
                                                                                      3 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 4,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     others                                     => False),
                                                                                         MaximaleLebenspunkte    => 5,
                                                                                         MaximaleBewegungspunkte => 10,
                                                                                         VerbesserungZu          => 8,
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
      
                                                                                        -- Erstes Schiff
                                                                                      4 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 10,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     others                                     => False),
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
                                               
                                                                                        -- Überwassereinheit
                                                                                      5 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 9,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     others                                     => False),
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
                                               
                                                                                        -- Überwassersiedler
                                                                                      6 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Arbeiter_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 12,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     others                                     => False),
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
                                               
                                                                                        -- Eisenkämpfer
                                                                                      7 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 21,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     others                                     => False),
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
                                               
                                                                                        -- Handelsschiff
                                                                                      8 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 18,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     others                                     => False),
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
                                               
                                                                                        -- Landsiedler
                                                                                      9 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 23,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Boden_Enum             => True,
                                                                                                                     others                                     => False),
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
                                               
                                                                                        -- Dampfschiff
                                                                                      10 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 29,
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
                                               
                                                                                        -- Motorschiff
                                                                                      11 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 36,
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
                                               
                                                                                        -- Schlachtschiff
                                                                                      12 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Beides_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 37,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     others                                     => False),
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
                                               
                                                                                        -- Auto
                                                                                      13 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 38,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Boden_Enum       => True,
                                                                                                                     others                               => False),
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
                                               
                                                                                        -- Genkämpfer
                                                                                      14 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 44,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Boden_Enum             => True,
                                                                                                                     others                                     => False),
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
                                               
                                                                                        -- Atombombe
                                                                                      15 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Einmalig_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 46,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Boden_Enum             => True,
                                                                                                                     others                                     => False),
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
                                                                                         Zusatzeffekt            => (KartengrundDatentypen.Strahlung_Enum => True,
                                                                                                                     others                               => False),
                                                                                         Effektreichweite        => (YAchseAnfang => -2,
                                                                                                                     YAchseEnde   => 2,
                                                                                                                     XAchseAnfang => -2,
                                                                                                                     XAchseEnde   => 2)
                                                                                        ),
                                               
                                                                                        -- Kernsiedler
                                                                                      16 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Arbeiter_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 48,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Boden_Enum             => True,
                                                                                                                     EinheitenDatentypen.Lava_Enum              => True,
                                                                                                                     EinheitenDatentypen.Planeteninneres_Enum   => True,
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
                                               
                                                                                        -- Kerngräber
                                                                                      17 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 48,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Boden_Enum             => True,
                                                                                                                     EinheitenDatentypen.Lava_Enum              => True,
                                                                                                                     EinheitenDatentypen.Planeteninneres_Enum   => True,
                                                                                                                     others                                     => False),
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
                                               
                                                                                        -- PZB200
                                                                                      18 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Einmalig_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 50,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Boden_Enum             => True,
                                                                                                                     others                                     => False),
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
                                                                                         Zusatzeffekt            => (KartengrundDatentypen.Vernichtet_Enum => True,
                                                                                                                     others                                => False),
                                                                                         Effektreichweite        => (
                                                                                                                     YAchseAnfang => -100,
                                                                                                                     YAchseEnde   => 100,
                                                                                                                     XAchseAnfang => -100,
                                                                                                                     XAchseEnde   => 100
                                                                                                                    )
                                                                                        ),
                                               
                                                                                        -- PZB400
                                                                                      19 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Einmalig_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 52,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Boden_Enum             => True,
                                                                                                                     others                                     => False),
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
                                                                                         Zusatzeffekt            => (KartengrundDatentypen.Vernichtet_Enum => True,
                                                                                                                     others                                => False),
                                                                                         Effektreichweite        => (
                                                                                                                     YAchseAnfang => -200,
                                                                                                                     YAchseEnde   => 200,
                                                                                                                     XAchseAnfang => -200,
                                                                                                                     XAchseEnde   => 200
                                                                                                                    )
                                                                                        ),
                                               
                                                                                        -- PZB1000
                                                                                      20 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Einmalig_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 52,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Wasser_Enum            => True,
                                                                                                                     EinheitenDatentypen.Küstenwasser_Enum      => True,
                                                                                                                     EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
                                                                                                                     EinheitenDatentypen.Boden_Enum             => True,
                                                                                                                     others                                     => False),
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
                                                                                         Zusatzeffekt            => (KartengrundDatentypen.Vernichtet_Enum => True,
                                                                                                                     others                                => False),
                                                                                         Effektreichweite        => (
                                                                                                                     YAchseAnfang => KartenDatentypen.Kartenfeld'First,
                                                                                                                     YAchseEnde   => KartenDatentypen.Kartenfeld'Last,
                                                                                                                     XAchseAnfang => KartenDatentypen.Kartenfeld'First,
                                                                                                                     XAchseEnde   => KartenDatentypen.Kartenfeld'Last
                                                                                                                    )
                                                                                        ),
                                               
                                                                                        -- Gaußkämpfer
                                                                                      21 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 54,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Weltraum_Enum => False,
                                                                                                                     EinheitenDatentypen.Luft_Enum     => False,
                                                                                                                     others => True),
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
                                                                                      22 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Arbeiter_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 59,
                                                                                         Passierbarkeit          => (others => True),
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
                                               
                                                                                        -- Magnetkämpfer
                                                                                      23 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 57,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
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
                                                                                         KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                                         Transportkapazität      => 0,
                                                                                         Zusatzeffekt            => (others => False),
                                                                                         Effektreichweite        => KartenRecordKonstanten.LeerEffektbereich
                                                                                        ),
                                               
                                                                                        -- Schwebepanzer
                                                                                      24 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 57,
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
                                               
                                                                                        -- Atmosphärenjäger
                                                                                      25 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Nahkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 57,
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
                                                                                      26 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 57,
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
                                               
                                                                                        -- Stellare Artillerie
                                                                                      27 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Fernkämpfer_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 57,
                                                                                         Passierbarkeit          => (EinheitenDatentypen.Unterwasser_Enum       => True,
                                                                                                                     EinheitenDatentypen.Unterküstenwasser_Enum => True,
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
                                               
                                                                                        -- Biowaffe
                                                                                      28 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Einmalig_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 52,
                                                                                         Passierbarkeit          => (others => True),
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
                                                                                         Zusatzeffekt            => (KartengrundDatentypen.Biologisch_Enum => True,
                                                                                                                     others                                => False),
                                                                                         Effektreichweite        => (YAchseAnfang => -2,
                                                                                                                     YAchseEnde   => 2,
                                                                                                                     XAchseAnfang => -2,
                                                                                                                     XAchseEnde   => 2)
                                                                                        ),
                                               
                                                                                        -- Chemische Waffe
                                                                                      29 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Einmalig_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 20,
                                                                                         Passierbarkeit          => (others => True),
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
                                                                                         Zusatzeffekt            => (KartengrundDatentypen.Chemisch_Enum => True,
                                                                                                                     others                              => False),
                                                                                         Effektreichweite        => (YAchseAnfang => -2,
                                                                                                                     YAchseEnde   => 2,
                                                                                                                     XAchseAnfang => -2,
                                                                                                                     XAchseEnde   => 2)
                                                                                        ),
                                               
                                                                                        -- Verschmutzende Waffe
                                                                                      30 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Einmalig_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 20,
                                                                                         Passierbarkeit          => (others => True),
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
                                                                                         Zusatzeffekt            => (KartengrundDatentypen.Verschmutzt_Enum => True,
                                                                                                                     others                                 => False),
                                                                                         Effektreichweite        => (YAchseAnfang => -2,
                                                                                                                     YAchseEnde   => 2,
                                                                                                                     XAchseAnfang => -2,
                                                                                                                     XAchseEnde   => 2)
                                                                                        ),
                                               
                                                                                        -- Einmal alle Feldeffekte
                                                                                      31 =>
                                                                                        (
                                                                                         Einheitenart            => EinheitenDatentypen.Einmalig_Enum,
                                                                                         PreisGeld               => 25,
                                                                                         Produktionskosten       => 20,
                                                                                         PermanenteKosten        => (others => 0),
                                                                                         Anforderungen           => 0,
                                                                                         Passierbarkeit          => (others => True),
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
                                                                                         Zusatzeffekt            => (KartengrundDatentypen.Vernichtet_Enum => False,
                                                                                                                     others                                => True),
                                                                                         Effektreichweite        => (YAchseAnfang => -2,
                                                                                                                     YAchseEnde   => 2,
                                                                                                                     XAchseAnfang => -2,
                                                                                                                     XAchseEnde   => 2)
                                                                                        ),
                                                                              
                                                                                      EinheitendatenbankRecord.EinheitenlisteArray'Last => DebugobjekteLogik.Alleskönner,
                                                               
                                                                                      others => EinheitenRecordKonstanten.LeerEinheitListe
                                                                                     );

end EinheitenTesorahn;

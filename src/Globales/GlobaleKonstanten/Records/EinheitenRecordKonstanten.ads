pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with DatenbankRecords;

package EinheitenRecordKonstanten is

   LeerEinheit : constant EinheitenRecords.EinheitenGebautRecord := (
                                                                     ID                           => EinheitenKonstanten.LeerID,
                                                                     KoordinatenAktuell           => KartenRecordKonstanten.LeerKoordinate,
                                                                     Heimatstadt                  => EinheitenKonstanten.LeerHeimatstadt,
                                                                     Lebenspunkte                 => EinheitenKonstanten.LeerLebenspunkte,
                                                                     Bewegungspunkte              => EinheitenKonstanten.LeerBewegungspunkte,
                                                                     Erfahrungspunkte             => EinheitenKonstanten.LeerErfahrungspunkte,
                                                                     Rang                         => EinheitenKonstanten.LeerRang,
                                                                     Beschäftigung                => EinheitenKonstanten.LeerBeschäftigung,
                                                                     BeschäftigungNachfolger      => EinheitenKonstanten.LeerBeschäftigung,
                                                                     Beschäftigungszeit           => EinheitenKonstanten.LeerBeschäftigungszeit,
                                                                     BeschäftigungszeitNachfolger => EinheitenKonstanten.LeerBeschäftigungszeit,
                                                                     KIZielKoordinaten            => KartenRecordKonstanten.LeerKoordinate,
                                                                     KIBeschäftigt                => EinheitenKonstanten.LeerKIBeschäftigt,
                                                                     KIBewegungPlan               => (others => KartenRecordKonstanten.LeerKoordinate),
                                                                     Transportiert                => (others => EinheitenKonstanten.LeerTransportiert),
                                                                     WirdTransportiert            => EinheitenKonstanten.LeerWirdTransportiert,
                                                                     Meldungen                    => (others => EinheitenKonstanten.LeerMeldung)
                                                                    );
   
   LeerEinheitListe : constant DatenbankRecords.EinheitenlisteRecord := (
                                                                         EinheitArt              => EinheitenKonstanten.LeerEinheitArt,
                                                                         PreisGeld               => EinheitenKonstanten.LeerPreisGeld,
                                                                         PreisRessourcen         => EinheitenKonstanten.LeerPreisRessourcen,
                                                                         PermanenteKosten        => (others => EinheitenKonstanten.LeerPermanenteKosten),
                                                                         Anforderungen           => EinheitenKonstanten.LeerAnforderungen,
                                                                         Passierbarkeit          => (others => EinheitenKonstanten.LeerPassierbarkeit),
                                                                         MaximaleLebenspunkte    => EinheitenKonstanten.LeerMaximaleLebenspunkte,
                                                                         MaximaleBewegungspunkte => EinheitenKonstanten.LeerMaximaleBewegungspunkte,
                                                                         WirdVerbessertZu        => EinheitenKonstanten.LeerWirdVerbessertZu,
                                                                         Beförderungsgrenze      => EinheitenKonstanten.LeerBeförderungsgrenze,
                                                                         MaximalerRang           => EinheitenKonstanten.LeerMaximalerRang,
                                                                         Reichweite              => EinheitenKonstanten.LeerReichweite,
                                                                         Angriff                 => EinheitenKonstanten.LeerAngriff,
                                                                         Verteidigung            => EinheitenKonstanten.LeerVerteidigung,
                                                                         KannTransportieren      => EinheitenKonstanten.LeerKannTransportieren,
                                                                         KannTransportiertWerden => EinheitenKonstanten.LeerKannTransportiertWerden,
                                                                         Transportkapazität      => EinheitenKonstanten.LeerTransportkapazität
                                                                        );
   
   KeineArbeit : constant EinheitenRecords.ArbeitRecord := (
                                                            WelcheArbeit => EinheitenKonstanten.LeerArbeit,
                                                            Arbeitszeit  => EinheitenKonstanten.LeerArbeitszeit
                                                           );

end EinheitenRecordKonstanten;

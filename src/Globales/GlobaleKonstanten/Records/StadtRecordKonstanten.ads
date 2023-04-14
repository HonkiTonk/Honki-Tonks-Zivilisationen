with StadtRecords;
with StadtKonstanten;
with KartenRecordKonstanten;
with GebaeudedatenbankRecord;

package StadtRecordKonstanten is
   pragma Elaborate_Body;

   LeerStadt : constant StadtRecords.StadtGebautRecord := (
                                                           ID                      => StadtKonstanten.LeerID,
                                                           KoordinatenAktuell      => KartenRecordKonstanten.LeerKoordinate,
                                                           EinwohnerArbeiter       => StadtKonstanten.LeerEinwohnerArbeiter,
                                                           Nahrungsmittel          => StadtKonstanten.LeerNahrungsmittel,
                                                           Nahrungsproduktion      => StadtKonstanten.LeerNahrungsproduktion,
                                                           Material                => StadtKonstanten.LeerMaterial,
                                                           Produktionrate          => StadtKonstanten.LeerProduktionrate,
                                                           Geldgewinnung           => StadtKonstanten.LeerGeldgewinnung,
                                                           PermanenteKostenPosten  => (others => StadtKonstanten.LeerPermanenteKosten),
                                                           Forschungsrate          => StadtKonstanten.LeerForschungsrate,
                                                           Bauprojekt              => StadtKonstanten.LeerBauprojekt,
                                                           Bauzeit                 => StadtKonstanten.LeerBauzeit,
                                                           Korruption              => StadtKonstanten.LeerKorruption,
                                                           Zufriedenheit           => StadtKonstanten.LeerZufriedenheit,
                                                           GebäudeVorhanden        => (others => StadtKonstanten.LeerGebäude),
                                                           Name                    => StadtKonstanten.LeerName,
                                                           UmgebungBewirtschaftung => (others => (others => StadtKonstanten.LeerUmgebungBewirtschaftet)),
                                                           UmgebungGröße           => StadtKonstanten.LeerUmgebungGröße,
                                                           Meldungen               => (others => StadtKonstanten.LeerMeldung),
                                                           KIBeschäftigung         => StadtKonstanten.LeerKIBeschäftigung
                                                          );
   
   LeerGebäudeListe : constant GebaeudedatenbankRecord.GebäudelisteRecord := (
                                                                                PreisGeld            => StadtKonstanten.LeerPreisGeld,
                                                                                Produktionskosten    => StadtKonstanten.LeerPreisRessourcen,
                                                                                PermanenteKosten     => (others => StadtKonstanten.LeerPermanenteKosten),
                                                                                Anforderungen        => StadtKonstanten.LeerAnforderungen,
                                                                                BonusWirtschaft      => (others => StadtKonstanten.LeerBonusWirtschaft),
                                                                                BonusKampf           => (others => StadtKonstanten.LeerBonusKampf),
                                                                                BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                               );

end StadtRecordKonstanten;

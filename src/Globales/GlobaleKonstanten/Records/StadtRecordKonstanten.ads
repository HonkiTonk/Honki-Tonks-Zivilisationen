pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtRecords;
with StadtKonstanten;
with KartenRecordKonstanten;

with DatenbankRecords;

package StadtRecordKonstanten is

   LeerStadt : constant StadtRecords.StadtGebautRecord := (
                                                           ID                      => StadtKonstanten.LeerID,
                                                           KoordinatenAktuell      => KartenRecordKonstanten.LeerKoordinate,
                                                           EinwohnerArbeiter       => StadtKonstanten.LeerEinwohnerArbeiter,
                                                           Nahrungsmittel          => StadtKonstanten.LeerNahrungsmittel,
                                                           Nahrungsproduktion      => StadtKonstanten.LeerNahrungsproduktion,
                                                           Ressourcen              => StadtKonstanten.LeerRessourcen,
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
                                                           UmgebungBewirtschaftung => (others => (others => StadtKonstanten.LeerUmgebungBewitschaftet)),
                                                           UmgebungGröße           => StadtKonstanten.LeerUmgebungGröße,
                                                           Meldungen               => (others => StadtKonstanten.LeerMeldung),
                                                           KIBeschäftigung         => StadtKonstanten.LeerKIBeschäftigung
                                                          );
   
   LeerGebäudeListe : constant DatenbankRecords.GebäudelisteRecord := (
                                                                         PreisGeld                   => StadtKonstanten.LeerPreisGeld,
                                                                         PreisRessourcen             => StadtKonstanten.LeerPreisRessourcen,
                                                                         PermanenteKosten            => (others => StadtKonstanten.LeerPermanenteKosten),
                                                                         Anforderungen               => StadtKonstanten.LeerAnforderungen,
                                                                         BonusWirtschaft             => (others => StadtKonstanten.LeerBonusWirtschaft),
                                                                         BonusKampf                  => (others => StadtKonstanten.LeerBonusKampf),
                                                                         GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                         FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                         RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                         GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                        );

end StadtRecordKonstanten;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with KartenDatentypen;
with StadtRecordKonstanten;

with DatenbankRecords;

package GebaeudeCarupex is

   GebäudelisteCarupex : constant DatenbankRecords.GebäudelisteArray := (
                                                                           -- Häuser
                                                                           1 =>
                                                                             (
                                                                              PreisGeld                   => 100,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 0,
                                                                              BonusWirtschaft             => (KartenDatentypen.Nahrung => 10,
                                                                                                              others                   => 0),
                                                                              BonusKampf                  => (others => 10),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Nahrungslager
                                                                           2 =>
                                                                             (
                                                                              PreisGeld                   => 100,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 2,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Holzpalisade
                                                                           3 =>
                                                                             (
                                                                              PreisGeld                   => 150,
                                                                              PreisRessourcen             => 50,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 1,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Schmiede
                                                                           4 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 10,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
      
                                                                             -- Bibliothek
                                                                           5 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 9,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Steinmauer
                                                                           6 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 11,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Bücherei
                                                                           7 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 21,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Bewässerungssystem
                                                                           8 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 16,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Kaserne
                                                                           9 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 13,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Wassermühle
                                                                           10 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 15,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Windmühle
                                                                           11 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 15,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Seehafen
                                                                           12 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 14,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Hochofen
                                                                           13 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 33,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Universität
                                                                           14 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 27,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Burg
                                                                           15 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 22,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Schwere Burg
                                                                           16 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 25,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Festungen
                                                                           17 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 34,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Kohlekraftwerk
                                                                           18 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 37,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Fabrik
                                                                           19 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 30,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Krankenhaus
                                                                           20 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 43,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Flughafen
                                                                           21 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 41,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Atomkraftwerk
                                                                           22 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 45,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Regenerative Kraftwerke (aufteilen oder zusammenlassen?)
                                                                           23 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 53,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Genklinik
                                                                           24 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 56,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- Fusionskraftwerk
                                                                           25 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 60,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                             
                                                                             -- NAMR Kraftwerk
                                                                           26 =>
                                                                             (
                                                                              PreisGeld                   => 1000,
                                                                              PreisRessourcen             => 100,
                                                                              PermanenteKosten            => (others => 0),
                                                                              Anforderungen               => 63,
                                                                              BonusWirtschaft             => (others => 0),
                                                                              BonusKampf                  => (others => 0),
                                                                              GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                              FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                              RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                              GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                             ),
                                                              
                                                                           others => StadtRecordKonstanten.LeerGebäudeListe
                                                                          );

end GebaeudeCarupex;

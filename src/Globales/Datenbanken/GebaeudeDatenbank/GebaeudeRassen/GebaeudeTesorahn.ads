pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with KartenDatentypen;
with StadtRecordKonstanten;
with KartengrundDatentypen;

with DatenbankRecords;

package GebaeudeTesorahn is

   GebäudelisteTesorahn : constant DatenbankRecords.GebäudelisteArray := (
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
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
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
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
      
                                                                              -- Bibliothek
                                                                            3 =>
                                                                              (
                                                                               PreisGeld                   => 1000,
                                                                               PreisRessourcen             => 100,
                                                                               PermanenteKosten            => (others => 0),
                                                                               Anforderungen               => 7,
                                                                               BonusWirtschaft             => (others => 0),
                                                                               BonusKampf                  => (others => 0),
                                                                               GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                               FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                               RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Kaserne
                                                                            4 =>
                                                                              (
                                                                               PreisGeld                   => 1000,
                                                                               PreisRessourcen             => 100,
                                                                               PermanenteKosten            => (others => 0),
                                                                               Anforderungen               => 4,
                                                                               BonusWirtschaft             => (others => 0),
                                                                               BonusKampf                  => (others => 0),
                                                                               GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                               FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                               RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Seehafen
                                                                            5 =>
                                                                              (
                                                                               PreisGeld                   => 1000,
                                                                               PreisRessourcen             => 100,
                                                                               PermanenteKosten            => (others => 0),
                                                                               Anforderungen               => 12,
                                                                               BonusWirtschaft             => (others => 0),
                                                                               BonusKampf                  => (others => 0),
                                                                               GrundBenötigt               => KartengrundDatentypen.Küstengewässer_Enum,
                                                                               FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                               RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Universität
                                                                            6 =>
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
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Kohlekraftwerk
                                                                            7 =>
                                                                              (
                                                                               PreisGeld                   => 1000,
                                                                               PreisRessourcen             => 100,
                                                                               PermanenteKosten            => (others => 0),
                                                                               Anforderungen               => 29,
                                                                               BonusWirtschaft             => (others => 0),
                                                                               BonusKampf                  => (others => 0),
                                                                               GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                               FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                               RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Apotheke
                                                                            8 =>
                                                                              (
                                                                               PreisGeld                   => 1000,
                                                                               PreisRessourcen             => 100,
                                                                               PermanenteKosten            => (others => 0),
                                                                               Anforderungen               => 19,
                                                                               BonusWirtschaft             => (others => 0),
                                                                               BonusKampf                  => (others => 0),
                                                                               GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                               FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                               RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Krankenhaus
                                                                            9 =>
                                                                              (
                                                                               PreisGeld                   => 1000,
                                                                               PreisRessourcen             => 100,
                                                                               PermanenteKosten            => (others => 0),
                                                                               Anforderungen               => 35,
                                                                               BonusWirtschaft             => (others => 0),
                                                                               BonusKampf                  => (others => 0),
                                                                               GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                               FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                               RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Genetikhaus
                                                                            10 =>
                                                                              (
                                                                               PreisGeld                   => 1000,
                                                                               PreisRessourcen             => 100,
                                                                               PermanenteKosten            => (others => 0),
                                                                               Anforderungen               => 44,
                                                                               BonusWirtschaft             => (others => 0),
                                                                               BonusKampf                  => (others => 0),
                                                                               GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                               FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                               RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Atomkraftwerk
                                                                            11 =>
                                                                              (
                                                                               PreisGeld                   => 1000,
                                                                               PreisRessourcen             => 100,
                                                                               PermanenteKosten            => (others => 0),
                                                                               Anforderungen               => 46,
                                                                               BonusWirtschaft             => (others => 0),
                                                                               BonusKampf                  => (others => 0),
                                                                               GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                               FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                               RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Gezeitenkraftwerk
                                                                            12 =>
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
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Handelshaus
                                                                            13 =>
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
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Marktplatz
                                                                            14 =>
                                                                              (
                                                                               PreisGeld                   => 1000,
                                                                               PreisRessourcen             => 100,
                                                                               PermanenteKosten            => (others => 0),
                                                                               Anforderungen               => 8,
                                                                               BonusWirtschaft             => (others => 0),
                                                                               BonusKampf                  => (others => 0),
                                                                               GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                               FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                               RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                             
                                                                              -- Kunstplatz
                                                                            15 =>
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
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                                                            
                                                                              -- Unionshaus
                                                                            16 =>
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
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                                                            
                                                                              -- NAMR Kraftwerk
                                                                            17 =>
                                                                              (
                                                                               PreisGeld                   => 1000,
                                                                               PreisRessourcen             => 100,
                                                                               PermanenteKosten            => (others => 0),
                                                                               Anforderungen               => 50,
                                                                               BonusWirtschaft             => (others => 0),
                                                                               BonusKampf                  => (others => 0),
                                                                               GrundBenötigt               => StadtKonstanten.LeerGrundBenötigt,
                                                                               FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                               RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                               VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                               GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                               GebäudeSpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                              ),
                                                              
                                                                            others => StadtRecordKonstanten.LeerGebäudeListe
                                                                           );
   
end GebaeudeTesorahn;

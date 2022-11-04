pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with StadtRecordKonstanten;
with GebaeudedatenbankRecord;
with ProduktionDatentypen;

package GebaeudeAspari2 is

   GebäudelisteAspari2 : constant GebaeudedatenbankRecord.GebäudelisteArray := (
                                                                                  -- Häuser
                                                                                  1 =>
                                                                                    (
                                                                                     PreisGeld                   => 100,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 0,
                                                                                     BonusWirtschaft             => (ProduktionDatentypen.Nahrung_Enum => 10,
                                                                                                                     others                            => 0),
                                                                                     BonusKampf                  => (others => 10),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Nahrungslager
                                                                                  2 =>
                                                                                    (
                                                                                     PreisGeld                   => 100,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 2,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Holzpalisade
                                                                                  3 =>
                                                                                    (
                                                                                     PreisGeld                   => 150,
                                                                                     Produktionskosten           => 50,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 1,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Schmiede
                                                                                  4 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 10,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
      
                                                                                    -- Bibliothek
                                                                                  5 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 9,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Steinmauer
                                                                                  6 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 11,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Bücherei
                                                                                  7 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 21,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Bewässerungssystem
                                                                                  8 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 16,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Kaserne
                                                                                  9 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 13,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Wassermühle
                                                                                  10 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 15,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Windmühle
                                                                                  11 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 15,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Seehafen
                                                                                  12 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 14,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Hochofen
                                                                                  13 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 33,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Universität
                                                                                  14 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 27,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Burg
                                                                                  15 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 22,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Schwere Burg
                                                                                  16 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 25,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Festungen
                                                                                  17 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 34,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Kohlekraftwerk
                                                                                  18 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 37,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Fabrik
                                                                                  19 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 30,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Krankenhaus
                                                                                  20 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 43,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Flughafen
                                                                                  21 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 41,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Atomkraftwerk
                                                                                  22 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 45,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Regenerative Kraftwerke (aufteilen oder zusammenlassen?)
                                                                                  23 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 53,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Genklinik
                                                                                  24 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 56,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Fusionskraftwerk
                                                                                  25 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 60,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- NAMR Kraftwerk
                                                                                  26 =>
                                                                                    (
                                                                                     PreisGeld                   => 1000,
                                                                                     Produktionskosten           => 100,
                                                                                     PermanenteKosten            => (others => 0),
                                                                                     Anforderungen               => 63,
                                                                                     BonusWirtschaft             => (others => 0),
                                                                                     BonusKampf                  => (others => 0),
                                                                                     BasisgrundBenötigt          => StadtKonstanten.LeerBasisgrundBenötigt,
                                                                                     FlussBenötigt               => StadtKonstanten.LeerFlussBenötigt,
                                                                                     RessourceBenötigt           => StadtKonstanten.LeerRessourceBenötigt,
                                                                                     VerbesserungBenötigt        => StadtKonstanten.LeerVerbesserungBenötigt,
                                                                                     GebäudeBenötigt             => StadtKonstanten.LeerGebäudeID,
                                                                                     EbeneBenötigt               => (others => False),
                                                                                     SpezielleEigenschaft        => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                                              
                                                                                  others => StadtRecordKonstanten.LeerGebäudeListe
                                                                                 );

end GebaeudeAspari2;

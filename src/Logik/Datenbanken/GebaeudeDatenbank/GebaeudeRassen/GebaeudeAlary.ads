pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with KartenDatentypen;
with EinheitStadtDatentypen;
with KartenGrundDatentypen;

with DatenbankRecords;

package GebaeudeAlary is

   GebäudeAlaryListe : constant DatenbankRecords.GebäudeListeArray := (
                                                                         -- Häuser
                                                                         1 =>
                                                                           (PreisGeld                   => 100,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 0,
                                                                            BonusWirtschaft             => (KartenDatentypen.Nahrung => 10,
                                                                                                            others                   => 0),
                                                                            BonusKampf                  => (others => 10),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Nahrungslager
                                                                         2 =>
                                                                           (PreisGeld                   => 100,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 2,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Holzpalisade
                                                                         3 =>
                                                                           (PreisGeld                   => 150,
                                                                            PreisRessourcen             => 50,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 1,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Schmiede
                                                                         4 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 10,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
      
                                                                         -- Bibliothek
                                                                         5 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 9,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Steinmauer
                                                                         6 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 11,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Bücherei
                                                                         7 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 21,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Bewässerungssystem
                                                                         8 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 16,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Kaserne
                                                                         9 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 13,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Wassermühle
                                                                         10 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 15,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Windmühle
                                                                         11 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 15,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Seehafen
                                                                         12 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 14,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Hochofen
                                                                         13 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 33,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Universität
                                                                         14 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 27,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Burg
                                                                         15 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 22,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Schwere Burg
                                                                         16 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 25,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Festungen
                                                                         17 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 34,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Kohlekraftwerk
                                                                         18 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 37,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Fabrik
                                                                         19 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 30,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Krankenhaus
                                                                         20 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 43,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Flughafen
                                                                         21 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 41,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Atomkraftwerk
                                                                         22 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 45,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Regenerative Kraftwerke (aufteilen oder zusammenlassen?)
                                                                         23 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 53,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Genklinik
                                                                         24 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 56,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- Fusionskraftwerk
                                                                         25 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 60,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                             
                                                                         -- NAMR Kraftwerk
                                                                         26 =>
                                                                           (PreisGeld                   => 1000,
                                                                            PreisRessourcen             => 100,
                                                                            PermanenteKosten            => (others => 0),
                                                                            Anforderungen               => 63,
                                                                            BonusWirtschaft             => (others => 0),
                                                                            BonusKampf                  => (others => 0),
                                                                            UmgebungBenötigt            => KartenGrundDatentypen.Leer_Grund_Enum,
                                                                            GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer_Enum),
                                                              
                                                                         others => StadtKonstanten.LeerGebäudeListe
                                                                        );
   
end GebaeudeAlary;

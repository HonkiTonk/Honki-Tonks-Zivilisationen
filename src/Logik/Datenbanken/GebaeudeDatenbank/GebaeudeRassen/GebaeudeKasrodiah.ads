pragma SPARK_Mode (On);

with StadtKonstanten;
with KartenDatentypen;
with EinheitStadtDatentypen;
with KartenGrundKonstanten;

with DatenbankRecords;

package GebaeudeKasrodiah is

   GebäudeKasrodiahListe : constant DatenbankRecords.GebäudeListeArray :=
     (
      -- Häuser
      1 =>
        (GebäudeGrafik               => 'A',
         PreisGeld                   => 100,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 0,
         BonusWirtschaft             => (KartenDatentypen.Nahrung => 10,
                                         others                   => 0),
         BonusKampf                  => (others => 10),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Nahrungslager
      2 =>
        (GebäudeGrafik               => 'B',
         PreisGeld                   => 100,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 2,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Holzpalisade
      3 =>
        (GebäudeGrafik               => 'C',
         PreisGeld                   => 150,
         PreisRessourcen             => 50,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 1,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Schmiede
      4 =>
        (GebäudeGrafik               => 'D',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 10,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
      
      -- Bibliothek
      5 =>
        (GebäudeGrafik               => 'E',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 9,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Steinmauer
      6 =>
        (GebäudeGrafik               => 'F',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 11,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Bücherei
      7 =>
        (GebäudeGrafik               => 'G',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 21,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Bewässerungssystem
      8 =>
        (GebäudeGrafik               => 'H',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 16,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Kaserne
      9 =>
        (GebäudeGrafik               => 'I',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 13,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Wassermühle
      10 =>
        (GebäudeGrafik               => 'J',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 15,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Windmühle
      11 =>
        (GebäudeGrafik               => 'K',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 15,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Seehafen
      12 =>
        (GebäudeGrafik               => 'L',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 14,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Hochofen
      13 =>
        (GebäudeGrafik               => 'M',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 33,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Universität
      14 =>
        (GebäudeGrafik               => 'N',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 27,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Burg
      15 =>
        (GebäudeGrafik               => 'O',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 22,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Schwere Burg
      16 =>
        (GebäudeGrafik               => 'P',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 25,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Festungen
      17 =>
        (GebäudeGrafik               => 'Q',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 34,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Kohlekraftwerk
      18 =>
        (GebäudeGrafik               => 'R',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 37,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Fabrik
      19 =>
        (GebäudeGrafik               => 'S',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 30,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Krankenhaus
      20 =>
        (GebäudeGrafik               => 'T',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 43,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Flughafen
      21 =>
        (GebäudeGrafik               => 'U',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 41,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Atomkraftwerk
      22 =>
        (GebäudeGrafik               => 'V',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 45,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Regenerative Kraftwerke (aufteilen oder zusammenlassen?)
      23 =>
        (GebäudeGrafik               => 'W',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 53,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Genklinik
      24 =>
        (GebäudeGrafik               => 'X',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 56,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Fusionskraftwerk
      25 =>
        (GebäudeGrafik               => 'Y',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 60,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- NAMR Kraftwerk
      26 =>
        (GebäudeGrafik               => 'Z',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 63,
         BonusWirtschaft             => (others => 0),
         BonusKampf                  => (others => 0),
         UmgebungBenötigt            => KartenGrundKonstanten.LeerGrund,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                                              
      others => StadtKonstanten.LeerGebäudeListe
     );

end GebaeudeKasrodiah;

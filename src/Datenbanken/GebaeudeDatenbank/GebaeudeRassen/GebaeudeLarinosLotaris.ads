pragma SPARK_Mode (On);

with StadtKonstanten, KartenDatentypen, EinheitStadtDatentypen;

with DatenbankRecords;

package GebaeudeLarinosLotaris is

   GebäudeLarinosLotarisListe : constant DatenbankRecords.GebäudeListeArray :=
     (
      -- Häuser
      1 =>
        (GebäudeGrafik               => 'A',
         PreisGeld                   => 100,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 0,
         PermanenterBonus            => (KartenDatentypen.Nahrung => 10,
                                         KartenDatentypen.Verteidigung => 10,
                                         KartenDatentypen.Angriff => 10,
                                         others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Nahrungslager
      2 =>
        (GebäudeGrafik               => 'B',
         PreisGeld                   => 100,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 2,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Holzpalisade
      3 =>
        (GebäudeGrafik               => 'C',
         PreisGeld                   => 150,
         PreisRessourcen             => 50,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 1,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Schmiede
      4 =>
        (GebäudeGrafik               => 'D',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 10,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
      
      -- Bibliothek
      5 =>
        (GebäudeGrafik               => 'E',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 9,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Steinmauer
      6 =>
        (GebäudeGrafik               => 'F',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 11,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Bücherei
      7 =>
        (GebäudeGrafik               => 'G',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 21,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Bewässerungssystem
      8 =>
        (GebäudeGrafik               => 'H',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 16,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Kaserne
      9 =>
        (GebäudeGrafik               => 'I',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 13,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Wassermühle
      10 =>
        (GebäudeGrafik               => 'J',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 15,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Windmühle
      11 =>
        (GebäudeGrafik               => 'K',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 15,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Seehafen
      12 =>
        (GebäudeGrafik               => 'L',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 14,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Hochofen
      13 =>
        (GebäudeGrafik               => 'M',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 33,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Universität
      14 =>
        (GebäudeGrafik               => 'N',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 27,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Burg
      15 =>
        (GebäudeGrafik               => 'O',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 22,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Schwere Burg
      16 =>
        (GebäudeGrafik               => 'P',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 25,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Festungen
      17 =>
        (GebäudeGrafik               => 'Q',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 34,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Kohlekraftwerk
      18 =>
        (GebäudeGrafik               => 'R',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 37,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Fabrik
      19 =>
        (GebäudeGrafik               => 'S',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 30,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Krankenhaus
      20 =>
        (GebäudeGrafik               => 'T',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 43,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Flughafen
      21 =>
        (GebäudeGrafik               => 'U',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 41,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Atomkraftwerk
      22 =>
        (GebäudeGrafik               => 'V',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 45,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Regenerative Kraftwerke (aufteilen oder zusammenlassen?)
      23 =>
        (GebäudeGrafik               => 'W',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 53,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Genklinik
      24 =>
        (GebäudeGrafik               => 'X',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 56,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- Fusionskraftwerk
      25 =>
        (GebäudeGrafik               => 'Y',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 60,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                             
      -- NAMR Kraftwerk
      26 =>
        (GebäudeGrafik               => 'Z',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 63,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => KartenDatentypen.Leer,
         GebäudeSpezielleEigenschaft => EinheitStadtDatentypen.Leer),
                                                              
      others => StadtKonstanten.LeerGebäudeListe
     );

end GebaeudeLarinosLotaris;

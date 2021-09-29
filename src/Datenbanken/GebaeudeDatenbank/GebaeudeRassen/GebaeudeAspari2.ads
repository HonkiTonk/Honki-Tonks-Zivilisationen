pragma SPARK_Mode (On);

with GlobaleDatentypen, StadtKonstanten;

with DatenbankRecords;

package GebaeudeAspari2 is

   GebäudeAspari2Liste : constant DatenbankRecords.GebäudeListeArray :=
     (
      -- Häuser
      1 =>
        (GebäudeGrafik               => 'A',
         PreisGeld                   => 100,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 0,
         PermanenterBonus            => (GlobaleDatentypen.Nahrung => 10,
                                         GlobaleDatentypen.Verteidigung => 10,
                                         GlobaleDatentypen.Angriff => 10,
                                         others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Nahrungslager
      2 =>
        (GebäudeGrafik               => 'B',
         PreisGeld                   => 100,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 2,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Holzpalisade
      3 =>
        (GebäudeGrafik               => 'C',
         PreisGeld                   => 150,
         PreisRessourcen             => 50,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 1,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Schmiede
      4 =>
        (GebäudeGrafik               => 'D',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 10,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
      
      -- Bibliothek
      5 =>
        (GebäudeGrafik               => 'E',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 9,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Steinmauer
      6 =>
        (GebäudeGrafik               => 'F',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 11,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Bücherei
      7 =>
        (GebäudeGrafik               => 'G',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 21,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Bewässerungssystem
      8 =>
        (GebäudeGrafik               => 'H',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 16,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Kaserne
      9 =>
        (GebäudeGrafik               => 'I',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 13,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Wassermühle
      10 =>
        (GebäudeGrafik               => 'J',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 15,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Windmühle
      11 =>
        (GebäudeGrafik               => 'K',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 15,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Seehafen
      12 =>
        (GebäudeGrafik               => 'L',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 14,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Hochofen
      13 =>
        (GebäudeGrafik               => 'M',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 33,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Universität
      14 =>
        (GebäudeGrafik               => 'N',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 27,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Burg
      15 =>
        (GebäudeGrafik               => 'O',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 22,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Schwere Burg
      16 =>
        (GebäudeGrafik               => 'P',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 25,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Festungen
      17 =>
        (GebäudeGrafik               => 'Q',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 34,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Kohlekraftwerk
      18 =>
        (GebäudeGrafik               => 'R',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 37,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Fabrik
      19 =>
        (GebäudeGrafik               => 'S',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 30,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Krankenhaus
      20 =>
        (GebäudeGrafik               => 'T',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 43,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Flughafen
      21 =>
        (GebäudeGrafik               => 'U',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 41,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Atomkraftwerk
      22 =>
        (GebäudeGrafik               => 'V',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 45,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Regenerative Kraftwerke (aufteilen oder zusammenlassen?)
      23 =>
        (GebäudeGrafik               => 'W',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 53,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Genklinik
      24 =>
        (GebäudeGrafik               => 'X',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 56,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Fusionskraftwerk
      25 =>
        (GebäudeGrafik               => 'Y',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 60,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- NAMR Kraftwerk
      26 =>
        (GebäudeGrafik               => 'Z',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 63,
         PermanenterBonus            => (others => 0),
         UmgebungBenötigt            => GlobaleDatentypen.Leer,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                                              
      others => StadtKonstanten.LeerGebäudeListe
     );

end GebaeudeAspari2;

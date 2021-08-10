pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;

with DatenbankRecords;

package GebaeudeTesorahn is

   GebäudeTesorahnListe : constant DatenbankRecords.GebäudeListeArray :=
     (
      -- Häuser
      1 =>
        (GebäudeGrafik               => 'A',
         PreisGeld                   => 100,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 0,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Nahrungslager
      2 =>
        (GebäudeGrafik               => 'B',
         PreisGeld                   => 100,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 2,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Holzpalisade
      3 =>
        (GebäudeGrafik               => 'C',
         PreisGeld                   => 150,
         PreisRessourcen             => 50,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 1,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Schmiede
      4 =>
        (GebäudeGrafik               => 'D',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 10,
         ProduktionBonus             => 2,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
      
      -- Bibliothek
      5 =>
        (GebäudeGrafik               => 'E',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 9,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Steinmauer
      6 =>
        (GebäudeGrafik               => 'F',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 11,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Bücherei
      7 =>
        (GebäudeGrafik               => 'G',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 21,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Bewässerungssystem
      8 =>
        (GebäudeGrafik               => 'H',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 16,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Kaserne
      9 =>
        (GebäudeGrafik               => 'I',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 13,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Wassermühle
      10 =>
        (GebäudeGrafik               => 'J',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 15,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Windmühle
      11 =>
        (GebäudeGrafik               => 'K',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 15,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Seehafen
      12 =>
        (GebäudeGrafik               => 'L',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 14,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Hochofen
      13 =>
        (GebäudeGrafik               => 'M',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 33,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Universität
      14 =>
        (GebäudeGrafik               => 'N',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 27,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Burg
      15 =>
        (GebäudeGrafik               => 'O',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 22,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Schwere Burg
      16 =>
        (GebäudeGrafik               => 'P',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 25,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Festungen
      17 =>
        (GebäudeGrafik               => 'Q',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 34,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Kohlekraftwerk
      18 =>
        (GebäudeGrafik               => 'R',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 37,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Fabrik
      19 =>
        (GebäudeGrafik               => 'S',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 30,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Krankenhaus
      20 =>
        (GebäudeGrafik               => 'T',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 43,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Flughafen
      21 =>
        (GebäudeGrafik               => 'U',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 41,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Atomkraftwerk
      22 =>
        (GebäudeGrafik               => 'V',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 45,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Regenerative Kraftwerke (aufteilen oder zusammenlassen?)
      23 =>
        (GebäudeGrafik               => 'W',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 53,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Genklinik
      24 =>
        (GebäudeGrafik               => 'X',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 56,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- Fusionskraftwerk
      25 =>
        (GebäudeGrafik               => 'Y',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 60,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- NAMR Kraftwerk
      26 =>
        (GebäudeGrafik               => 'Z',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 63,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                                              
      others => GlobaleKonstanten.LeerGebäudeListe
     );

end GebaeudeTesorahn;

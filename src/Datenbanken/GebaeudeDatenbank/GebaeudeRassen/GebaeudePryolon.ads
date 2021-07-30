pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;

with DatenbankRecords;

package GebaeudePryolon is

   GebäudePryolonListe : constant DatenbankRecords.GebäudeListeArray :=
     (
      -- Holzhäuser
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
                                             
      -- Rathaus
      2 =>
        (GebäudeGrafik               => 'B',
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
         Anforderungen               => 5,
         ProduktionBonus             => 2,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
      -- 
      5 =>
        (GebäudeGrafik               => 'E',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 1,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- 
      6 =>
        (GebäudeGrafik               => 'F',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 1,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- 
      7 =>
        (GebäudeGrafik               => 'G',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 1,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- 
      8 =>
        (GebäudeGrafik               => 'H',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 1,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- 
      9 =>
        (GebäudeGrafik               => 'I',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 1,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),
                                             
      -- 
      10 =>
        (GebäudeGrafik               => 'J',
         PreisGeld                   => 1000,
         PreisRessourcen             => 100,
         PermanenteKosten            => (others => 0),
         Anforderungen               => 1,
         ProduktionBonus             => 0,
         GeldBonus                   => 0,
         WissenBonus                 => 0,
         VerteidigungBonus           => 0,
         NahrungBonus                => 0,
         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer),                                             
                                                              
      others => GlobaleKonstanten.LeerGebäudeListe
     );

end GebaeudePryolon;

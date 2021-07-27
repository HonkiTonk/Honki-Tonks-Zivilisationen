pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package GebaeudeDatenbank is

   type GebäudeListeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.GebäudeID'Range) of DatenbankRecords.GebäudeListeRecord;
   GebäudeListe : GebäudeListeArray := (
                                          GlobaleDatentypen.Rasse_1 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_2 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_3 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_4 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_5 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_6 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_7 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_8 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_9 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_10 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_11 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_12 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_13 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_14 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_15 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_16 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_17 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                          GlobaleDatentypen.Rasse_18 =>
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
                                                              
                                             others => GlobaleKonstanten.LeerGebäudeListe)
                                         );
   
   procedure StandardGebaeudeDatenbankWiederherstellen;
   
private
   
   GebäudeListeStandard : constant GebäudeListeArray := (
                                                           GlobaleDatentypen.Rasse_1 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_2 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_3 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_4 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_5 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_6 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_7 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_8 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_9 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_10 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_11 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_12 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_13 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_14 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_15 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_16 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_17 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe),
                                                   
                                                           GlobaleDatentypen.Rasse_18 =>
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
                                                              
                                                              others => GlobaleKonstanten.LeerGebäudeListe)
                                                          );

end GebaeudeDatenbank;

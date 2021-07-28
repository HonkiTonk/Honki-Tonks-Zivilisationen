pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package GebaeudeDatenbank is

   type GebäudeListeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.GebäudeID'Range) of DatenbankRecords.GebäudeListeRecord;
   GebäudeListe : GebäudeListeArray := (
                                          GlobaleDatentypen.Menschen =>
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
                                                   
                                          GlobaleDatentypen.Maschinen =>
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
                                                   
                                          GlobaleDatentypen.Biber =>
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
                                                   
                                          GlobaleDatentypen.Wölfe =>
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
                                                   
                                          GlobaleDatentypen.Fischotter =>
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
                                                   
                                          GlobaleDatentypen.Marderhund =>
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
                                                   
                                          GlobaleDatentypen.Wildschwein =>
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
                                                   
                                          GlobaleDatentypen.Waschbär =>
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
                                                   
                                          GlobaleDatentypen.Maulwurf =>
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
                                                   
                                          GlobaleDatentypen.Ziesel =>
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
                                                   
                                          GlobaleDatentypen.Spinnen =>
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
                                                   
                                          GlobaleDatentypen.Steinbock =>
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
                                                   
                                          GlobaleDatentypen.Greifvögel =>
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
                                                   
                                          GlobaleDatentypen.Fische =>
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
                                                   
                                          GlobaleDatentypen.Schlangen =>
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
                                                   
                                          GlobaleDatentypen.Salamander =>
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
                                                   
                                          GlobaleDatentypen.Pflanzen =>
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
                                                   
                                          GlobaleDatentypen.Igel =>
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
   
   procedure StandardGebaeudeDatenbankLaden;
   
private
   
   GebäudeListeStandard : constant GebäudeListeArray := (
                                                           GlobaleDatentypen.Menschen =>
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
                                                   
                                                           GlobaleDatentypen.Maschinen =>
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
                                                   
                                                           GlobaleDatentypen.Biber =>
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
                                                   
                                                           GlobaleDatentypen.Wölfe =>
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
                                                   
                                                           GlobaleDatentypen.Fischotter =>
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
                                                   
                                                           GlobaleDatentypen.Marderhund =>
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
                                                   
                                                           GlobaleDatentypen.Wildschwein =>
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
                                                   
                                                           GlobaleDatentypen.Waschbär =>
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
                                                   
                                                           GlobaleDatentypen.Maulwurf =>
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
                                                   
                                                           GlobaleDatentypen.Ziesel =>
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
                                                   
                                                           GlobaleDatentypen.Spinnen =>
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
                                                   
                                                           GlobaleDatentypen.Steinbock =>
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
                                                   
                                                           GlobaleDatentypen.Greifvögel =>
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
                                                   
                                                           GlobaleDatentypen.Fische =>
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
                                                   
                                                           GlobaleDatentypen.Schlangen =>
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
                                                   
                                                           GlobaleDatentypen.Salamander =>
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
                                                   
                                                           GlobaleDatentypen.Pflanzen =>
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
                                                   
                                                           GlobaleDatentypen.Igel =>
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

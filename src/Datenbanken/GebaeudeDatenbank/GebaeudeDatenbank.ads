pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package GebaeudeDatenbank is

   -- GebäudeGrafik, PreisGeld, PreisRessourcen, Anforderungen, PermanenteKosten
   -- ProduktionBonus, GeldBonus, WissenBonus, VerteidigungBonus, NahrungBonus
   -- Anderes

   type GebäudeListeArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.GebäudeID'Range) of DatenbankRecords.GebäudeListeRecord;
   GebäudeListe : GebäudeListeArray := (
                                          1 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          2 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          3 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          4 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          5 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          6 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          7 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          8 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          9 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          10 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          11 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          12 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          13 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          14 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          15 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          16 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          17 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                          18 =>
                                            (
                                             -- Holzhäuser
                                             1 => ('A', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Rathaus
                                             2 => ('B', 100, 100, 0, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Nahrungslager
                                             3 => ('C', 150, 50, 1, 0,
                                                   0, 0, 0, 0, 0, False),
                                             -- Schmiede
                                             4 => ('D', 1000, 100, 5, 1,
                                                   2, 0, 0, 0, 0, False),
                                             -- 
                                             5 => ('E', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             6 => ('F', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             7 => ('G', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             8 => ('H', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             9 => ('I', 1000, 100, 1, 1,
                                                   0, 0, 0, 0, 0, False),
                                             -- 
                                             10 => ('J', 1000, 100, 1, 1,
                                                    0, 0, 0, 0, 0, False),
                                                              
                                             others => GlobaleKonstanten.LeererWertGebäudeListe)
                                         );
   
   procedure StandardGebaeudeDatenbankWiederherstellen;

   type RassenAufschlagArray is array (GlobaleDatentypen.Rassen'Range) of Natural;
   RassenAufschlagForschung : constant RassenAufschlagArray := (1 => 0,
                                                                2 => 0,
                                                                3 => 0,
                                                                4 => 0,
                                                                5 => 0,
                                                                6 => 0,
                                                                7 => 0,
                                                                8 => 0,
                                                                9 => 0,
                                                                10 => 0,
                                                                11 => 0,
                                                                12 => 0,
                                                                13 => 0,
                                                                14 => 0,
                                                                15 => 0,
                                                                16 => 0,
                                                                17 => 0,
                                                                18 => 0);
   
private
   
   GebäudeListeStandard : constant GebäudeListeArray := (
                                                           1 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           2 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           3 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           4 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           5 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           6 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           7 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           8 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           9 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           10 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           11 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           12 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           13 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           14 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           15 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           16 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           17 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe),
                                                   
                                                           18 =>
                                                             (
                                                              -- Holzhäuser
                                                              1 => ('A', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Rathaus
                                                              2 => ('B', 100, 100, 0, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Nahrungslager
                                                              3 => ('C', 150, 50, 1, 0,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- Schmiede
                                                              4 => ('D', 1000, 100, 5, 1,
                                                                    2, 0, 0, 0, 0, False),
                                                              -- 
                                                              5 => ('E', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              6 => ('F', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              7 => ('G', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              8 => ('H', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              9 => ('I', 1000, 100, 1, 1,
                                                                    0, 0, 0, 0, 0, False),
                                                              -- 
                                                              10 => ('J', 1000, 100, 1, 1,
                                                                     0, 0, 0, 0, 0, False),
                                                              
                                                              others => GlobaleKonstanten.LeererWertGebäudeListe)
                                                          );

end GebaeudeDatenbank;

pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package GebaeudeDatenbank is

   -- GebäudeGrafik, PreisGeld, PreisRessourcen, Anforderungen, PermanenteKosten
   -- ProduktionBonus, GeldBonus, WissenBonus, VerteidigungBonus, NahrungBonus
   -- Anderes

   type GebäudeListeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.GebäudeID'Range) of DatenbankRecords.GebäudeListeRecord;
   GebäudeListe : GebäudeListeArray := (
                                          GlobaleDatentypen.Rasse_1 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_2 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_3 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_4 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_5 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_6 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_7 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_8 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_9 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_10 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_11 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_12 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_13 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_14 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_15 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_16 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_17 =>
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
                                                   
                                          GlobaleDatentypen.Rasse_18 =>
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
   
private
   
   GebäudeListeStandard : constant GebäudeListeArray := (
                                                           GlobaleDatentypen.Rasse_1 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_2 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_3 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_4 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_5 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_6 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_7 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_8 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_9 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_10 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_11 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_12 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_13 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_14 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_15 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_16 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_17 =>
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
                                                   
                                                           GlobaleDatentypen.Rasse_18 =>
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

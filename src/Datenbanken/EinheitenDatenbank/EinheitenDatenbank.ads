pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package EinheitenDatenbank is

   -- EinheitTyp: 1 = Siedler, 2 = Bauarbeiter, 3 = Platzhalter für Anderes (später einbauen/nutzen)   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch, Planeteninneres
   
   -- EinheitenGrafik, EinheitTyp, PreisGeld, PreisRessourcen, Anforderungen
   -- Passierbarkeit
   -- MaximaleLebenspunkte, MaximaleBewegungspunkte, WirdVerbesserZu
   -- Beförderungsgrenze, MaximalerRang, Reichweite, Angriff, Verteidigung
   -- Kann Dinge transportieren, Kann transportiert werden, Transportkapazität
   
   type EinheitenListeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.EinheitenID'Range) of DatenbankRecords.EinheitenListeRecord;
   EinheitenListe : EinheitenListeArray := (
                                            GlobaleDatentypen.Rasse_1 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 4,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 8,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_2 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_3 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_4 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_5 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_6 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_7 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_8 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_9 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_10 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_11 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_12 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_13 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_14 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_15 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_16 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_17 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                            GlobaleDatentypen.Rasse_18 =>
                                              (
                                               -- Siedler
                                               1 => ('S', 1, 10, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     0, 1, 0),
                                               -- Steinbeilkämpfer
                                               2 => ('L', 3, 25, 20, 0,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Bogenschütze
                                               3 => ('L', 3, 25, 20, 5,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     5, 3.00, 0,
                                                     30, 3, 1, 3, 1,
                                                     0, 1, 0),
                                               -- Kanone
                                               4 => ('L', 4, 50, 5, 20,
                                                     (GlobaleDatentypen.Boden => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 3, 8, 1,
                                                     0, 2, 0),
                                               -- Ägyptisches Nilschiff
                                               5 => ('S', 5, 20, 10, 11,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     2, 3.00, 0,
                                                     30, 3, 1, 1, 1,
                                                     2, 0, 0),
                                               -- Kanonenschiff
                                               6 => ('S', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, others => False),
                                                     3, 3.00, 0,
                                                     30, 3, 1, 8, 1,
                                                     2, 0, 0),
                                               -- UBoot
                                               7 => ('U', 6, 20, 10, 20,
                                                     (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                     1000, 100.00, 0,
                                                     30, 3, 1, 10, 10,
                                                     0, 0, 0),
                                               -- Jäger
                                               8 => ('F', 7, 100, 10, 20,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     0, 1, 0),
                                               -- Bomber
                                               9 => ('F', 8, 100, 10, 0,
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                     8, 3.00, 0,
                                                     30, 3, 1, 10, 1,
                                                     2, 0, 0),
                                               -- Rakete
                                               10 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Unterwasserrakete
                                               11 => ('R', 7, 20, 10, 20,
                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                       GlobaleDatentypen.Unterwasser => True, others => False),
                                                      1000, 100.00, 0,
                                                      30, 3, 1, 10, 10,
                                                      0, 0, 0),
                                               -- Alleskönner
                                               12 => ('A', 7, 1, 1, 0,
                                                      (others => True),
                                                      100, 100.00, 0,
                                                      1, 1, 1, 1, 1,
                                                      0, 0, 0),
                                                               
                                               others => GlobaleKonstanten.LeererWertEinheitListe)
                                           );
   
   -- 1. EinheitTyp = Siedler, 2. EinheitenTyp = Bauarbeiter, 3. EinheitenTyp = Platzhalter für Anderes !!!Später einbauen/nutzen!!!
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch, Planeteninneres
   
   procedure StandardEinheitenDatenbankWiederherstellen;

private
   
   EinheitenListeStandard : constant EinheitenListeArray := (
                                                             GlobaleDatentypen.Rasse_1 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_2 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_3 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_4 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_5 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_6 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_7 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_8 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_9 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, 
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_10 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_11 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_12 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_13 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_14 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_15 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_16 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_17 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe),
         
                                                             GlobaleDatentypen.Rasse_18 =>
                                                               (
                                                                -- Siedler
                                                                1 => ('S', 1, 10, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      0, 1, 0),
                                                                -- Steinbeilkämpfer
                                                                2 => ('L', 3, 25, 20, 0,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Bogenschütze
                                                                3 => ('L', 3, 25, 20, 5,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      5, 3.00, 0,
                                                                      30, 3, 1, 3, 1,
                                                                      0, 1, 0),
                                                                -- Kanone
                                                                4 => ('L', 4, 50, 5, 20,
                                                                      (GlobaleDatentypen.Boden => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 3, 8, 1,
                                                                      0, 2, 0),
                                                                -- Ägyptisches Nilschiff
                                                                5 => ('S', 5, 20, 10, 11,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      2, 3.00, 0,
                                                                      30, 3, 1, 1, 1,
                                                                      2, 0, 0),
                                                                -- Kanonenschiff
                                                                6 => ('S', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, others => False),
                                                                      3, 3.00, 0,
                                                                      30, 3, 1, 8, 1,
                                                                      2, 0, 0),
                                                                -- UBoot
                                                                7 => ('U', 6, 20, 10, 20,
                                                                      (GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Unterwasser => True, others => False),
                                                                      1000, 100.00, 0,
                                                                      30, 3, 1, 10, 10,
                                                                      0, 0, 0),
                                                                -- Jäger
                                                                8 => ('F', 7, 100, 10, 20,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      0, 1, 0),
                                                                -- Bomber
                                                                9 => ('F', 8, 100, 10, 0,
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, others => False),
                                                                      8, 3.00, 0,
                                                                      30, 3, 1, 10, 1,
                                                                      2, 0, 0),
                                                                -- Rakete
                                                                10 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Unterwasserrakete
                                                                11 => ('R', 7, 20, 10, 20,
                                                                       (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Wasser => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,
                                                                        GlobaleDatentypen.Unterwasser => True, others => False),
                                                                       1000, 100.00, 0,
                                                                       30, 3, 1, 10, 10,
                                                                       0, 0, 0),
                                                                -- Alleskönner
                                                                12 => ('A', 7, 1, 1, 0,
                                                                       (others => True),
                                                                       100, 100.00, 0,
                                                                       1, 1, 1, 1, 1,
                                                                       0, 0, 0),
                                                               
                                                                others => GlobaleKonstanten.LeererWertEinheitListe)
                                                            );

end EinheitenDatenbank;

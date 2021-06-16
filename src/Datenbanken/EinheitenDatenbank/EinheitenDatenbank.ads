pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

with DatenbankRecords;

package EinheitenDatenbank is

   LeererWertEinheitListe : constant DatenbankRecords.EinheitenListeRecord := ('@', -- EinheitenGrafik
                                                                               1, 0, 0, 0, -- EinheitTyp, PreisGeld, PreisRessourcen, Anforderungen
                                                                               (others => False), 0, 0.00, -- Passierbarkeit, MaximaleLebenspunkte, MaximaleBewegungspunkte
                                                                               1, 1, 0, 0, 1, -- Beförderungsgrenze, MaximalerRang, Reichweite, Angriff, Verteidigung
                                                                               0, 0, 0); -- Kann Dinge transportieren, Kann transportiert werden, Transportkapazität

   -- EinheitTyp: 1 = Siedler, 2 = Bauarbeiter, 3 = Platzhalter für Anderes !!!Später einbauen/nutzen!!!
   -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch, 7 = Planeteninneres
   type EinheitenListeArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.EinheitenID'Range) of DatenbankRecords.EinheitenListeRecord;
   EinheitenListe : EinheitenListeArray
     := (1 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 3.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 3.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 3.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 0,   (1 => True, 2 => True, 3 => True, others => False), 8, 3.00,    30, 3, 1, 10, 1,    2, 0, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         2 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         3 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         4 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         5 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         6 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         7 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         8 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         9 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         10 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         11 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         12 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         13 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         14 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         15 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         16 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         17 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         18 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe));
   -- 1. EinheitTyp = Siedler, 2. EinheitenTyp = Bauarbeiter, 3. EinheitenTyp = Platzhalter für Anderes !!!Später einbauen/nutzen!!!
   -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch, 7 = Planeteninneres
   
   procedure StandardEinheitenDatenbankWiederherstellen;

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
   
   EinheitenListeStandard : constant EinheitenListeArray
     := (1 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         2 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         3 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         4 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         5 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         6 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         7 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         8 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         9 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

               ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
               ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
               ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

               ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
               ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
               ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
               ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
               ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
               ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
               others => LeererWertEinheitListe),
         
         10 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         11 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         12 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         13 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         14 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         15 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         16 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         17 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe),
         
         18 => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1, 0), -- Siedler

                ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Steinbeilkämpfer
                ('L',    3, 25, 20, 5,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1, 0), -- Bogenschütze
                ('L',    4, 50, 5, 20,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2, 0), -- Kanone

                ('S',    5, 20, 10, 11,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0, 0), -- Ägyptisches Nilschiff
                ('S',    6, 20, 10, 20,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0, 0), -- Kanonenschiff
                ('U',    6, 20, 10, 20,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- UBoot
                                                    
                ('F',    7, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Jäger
                ('F',    8, 100, 10, 20,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1, 0), -- Bomber
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Rakete
                ('R',    7, 20, 10, 20,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0, 0), -- Unterwasserrakete                    
                                                               
                others => LeererWertEinheitListe));
     
end EinheitenDatenbank;

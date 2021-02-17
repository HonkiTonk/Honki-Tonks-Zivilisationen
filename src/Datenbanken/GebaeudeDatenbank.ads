pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen, DatenbankRecords, GlobaleRecords;
use GlobaleDatentypen;

package GebaeudeDatenbank is

   -- Hier noch hinschreiben welcher Wert was ist!
   LeererWertGebäudeListe : constant DatenbankRecords.GebäudeListeRecord := (' ', -- 1. Wert = GebäudeGrafik
                                                                               0, 0, 0, 0, -- 2. Wert = PreisGeld, 3. Wert = PreisRessourcen, 4. Wert = Anforderungen, 5. Wert = PermanenteKosten
                                                                               0, 0, 0, 0, 0, -- 6. Wert = ProduktionBonus, 7. Wert = GeldBonus, 8. Wert = WissenBonus, 9. Wert = VerteidigungBonus, 10. Wert = NahrungBonus
                                                                               False); -- 11. Wert = Anderes

   type GebäudeListeArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.GebäudeID'Range) of DatenbankRecords.GebäudeListeRecord;
   GebäudeListe : constant GebäudeListeArray := (others => (('A',    100, 100, 0, 0,    0, 0, 0, 0, 0,    False), -- 1 
                                                              ('B',    100, 100, 1, 0,    0, 0, 0, 0, 0,    False), -- 2 
                                                              ('C',    150, 50, 2, 0,    0, 0, 0, 0, 0,    False), -- 3 
                                                              ('D',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 4
                                                              ('E',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 5
                                                              ('F',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 6
                                                              ('G',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 7
                                                              ('H',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 8
                                                              ('I',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 9
                                                              ('J',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 10
                                                              ('K',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 11
                                                              ('L',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 12
                                                              ('M',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 13
                                                              ('N',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 14
                                                              ('O',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 15
                                                              ('P',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 16
                                                              ('Q',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 17
                                                              ('R',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 18
                                                              ('S',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 19
                                                              ('T',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 20
                                                              ('U',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 21
                                                              ('V',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 22
                                                              ('W',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 23
                                                              ('X',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 24
                                                              ('Y',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 25
                                                              ('Z',    1000, 100, 1, 1,    0, 0, 0, 0, 0,    False), -- 26
                                                              
                                                              others => LeererWertGebäudeListe));

   procedure Beschreibung (ID : in GebäudeID);
   procedure GebäudeProduktionBeenden (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord; ID : in GebäudeID) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen);

private
   
   

end GebaeudeDatenbank;

pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen, DatenbankRecords, GlobaleRecords;
use GlobaleDatentypen;

package GebaeudeDatenbank is

   type GebäudeListeArray is array (GlobaleDatentypen.Rassen'Range, GlobaleVariablen.StadtGebaut (1, 1).GebäudeVorhanden'Range) of DatenbankRecords.GebäudeListeRecord;
   GebäudeListe : constant GebäudeListeArray := (others => (('B', 100, 100, 0,    0, 0, 0, 0, 0, 0, False), -- 1 
                                                              ('K', 100, 100, 1,    0, 0, 0, 0, 0, 0, False), -- 2 
                                                              ('F', 150, 50, 2,    0, 0, 0, 0, 0, 0, False), -- 3 
                                          
                                                              others => (' ', 0, 0, 0,    0, 0, 0, 0, 0, 0, False)));

   procedure Beschreibung (ID : in Positive);   
   procedure GebäudeProduktionBeenden (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord; ID : in Positive) with
     Pre => StadtRasseUndNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

private

   PlatzVorhanden : Boolean;      

end GebaeudeDatenbank;

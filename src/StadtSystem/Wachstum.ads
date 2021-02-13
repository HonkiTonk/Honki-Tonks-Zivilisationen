pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package Wachstum is
   
   procedure Wachstum;
   procedure WachstumBeiStadtGründung (RasseExtern : in GlobaleDatentypen.Rassen);

private
   
   procedure WachstumEinwohner (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure WachstumProduktion (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

end Wachstum;

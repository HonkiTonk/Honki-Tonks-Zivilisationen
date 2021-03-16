pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package Wachstum is
   
   procedure Wachstum;
   procedure WachstumBeiStadtGründung (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

private
   
   procedure WachstumEinwohner (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= 0));

   procedure WachstumProduktion (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= 0));

end Wachstum;

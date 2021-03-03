pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package Wachstum is
   
   procedure Wachstum;
   procedure WachstumBeiStadtGründung (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

private
   
   procedure WachstumEinwohner (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0));

   procedure WachstumProduktion (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0));

end Wachstum;

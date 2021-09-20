pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package Wachstum is
   
   procedure StadtWachstum;
   
   procedure WachstumWichtiges
     (RasseExtern : in GlobaleDatentypen.Rassen_Enum);
   
private
   
   WachstumSchrumpfung : Boolean;
   
   procedure WachstumEinwohner
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

   procedure WachstumProduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   procedure WachstumsratenBerechnen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   procedure EinwohnerÄnderung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure NeuerEinwohner
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

end Wachstum;

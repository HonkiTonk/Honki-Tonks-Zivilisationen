pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package StadtWerteFestlegen is

   RassenMulitplikationWert : constant GlobaleDatentypen.BelegterGrund := 1_000;

   procedure BewirtschaftbareFelderBelegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre => (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and (if StadtRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= 0));

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre => (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and (if StadtRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= 0));

   procedure BelegteStadtfelderFreigeben
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre => (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and (if StadtRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= 0));

private
   
   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

end StadtWerteFestlegen;

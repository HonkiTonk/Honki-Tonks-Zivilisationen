pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package StadtWerteFestlegen is

   RassenMulitplikationWert : constant GlobaleDatentypen.BelegterGrund := 1_000;

   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : Boolean; StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure StadtUmgebungGrößeFestlegen (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

private
   
   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   KartenWert : GlobaleRecords.AchsenKartenfeldRecord;

end StadtWerteFestlegen;

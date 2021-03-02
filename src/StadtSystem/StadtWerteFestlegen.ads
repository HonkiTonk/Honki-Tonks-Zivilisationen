pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package StadtWerteFestlegen is

   RassenMulitplikationWert : constant GlobaleDatentypen.BelegterGrund := 1_000;

   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : in Boolean; StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen and GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0);

   procedure StadtUmgebungGrößeFestlegen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen and GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0);

   procedure BelegteStadtfelderFreigeben (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen and GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0);

private
   
   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

end StadtWerteFestlegen;

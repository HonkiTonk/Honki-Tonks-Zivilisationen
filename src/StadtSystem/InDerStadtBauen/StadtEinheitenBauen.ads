pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package StadtEinheitenBauen is

   procedure EinheitFertiggestellt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
   
private
   
   Umgebung : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
   
   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   
   BereitsVonEinheitBelegt : GlobaleRecords.RassePlatznummerRecord;
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

end StadtEinheitenBauen;

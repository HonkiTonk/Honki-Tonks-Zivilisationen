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
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
private
    
   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;   

end StadtEinheitenBauen;

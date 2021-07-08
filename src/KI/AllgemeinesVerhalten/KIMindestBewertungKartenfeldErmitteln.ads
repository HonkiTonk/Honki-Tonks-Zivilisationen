pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package KIMindestBewertungKartenfeldErmitteln is

   function MindestBewertungKartenfeldStadtBauen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
private
   
   MindestBewertungKartenfeld : GlobaleDatentypen.GesamtproduktionStadt;
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

end KIMindestBewertungKartenfeldErmitteln;

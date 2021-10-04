pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen, EinheitStadtRecords, KartenRecords;
use GlobaleDatentypen;

package KIMindestBewertungKartenfeldErmitteln is

   function MindestBewertungKartenfeldStadtBauen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
private
   
   MindestBewertungKartenfeld : EinheitStadtDatentypen.GesamtproduktionStadt;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

end KIMindestBewertungKartenfeldErmitteln;

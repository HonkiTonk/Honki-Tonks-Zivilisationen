pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, EinheitStadtRecords, KartenRecords;
use GlobaleDatentypen;

package KIFeindlicheEinheitSuchen is

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FeindExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (FeindExtern) /= GlobaleDatentypen.Leer
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
private
   
   FeindlicheEinheit : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

end KIFeindlicheEinheitSuchen;

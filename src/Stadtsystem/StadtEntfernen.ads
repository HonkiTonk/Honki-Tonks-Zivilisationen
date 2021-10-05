pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleVariablen, KartenRecords, SonstigeDatentypen;
use SonstigeDatentypen;

package StadtEntfernen is

   procedure StadtEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure BelegteStadtfelderFreigeben
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure HeimatstädteEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure NeueHauptstadtSetzen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end StadtEntfernen;

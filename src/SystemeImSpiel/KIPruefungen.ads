pragma SPARK_Mode (On);

with KIRecords, GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

package KIPruefungen is
   
   function EinheitenAbstandBerechnen (EinheitEinsRasseNummer, EinheitZweiRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Natural;
   
private

   KartenfeldAbstand : GlobaleDatentypen.Kartenfeld;
   
end KIPruefungen;

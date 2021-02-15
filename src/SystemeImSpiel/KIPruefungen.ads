pragma SPARK_Mode (On);

with KIRecords, GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KIPruefungen is
   
   procedure ZielBerechnenGefahr (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   function EinheitenAbstandBerechnen (EinheitEinsRasseNummer, EinheitZweiRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Natural with
     Pre => EinheitEinsRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitEinsRasseNummer.Rasse in GlobaleDatentypen.Rassen
     and EinheitZweiRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitZweiRasseNummer.Rasse in GlobaleDatentypen.Rassen;
   
private

   Richtung : Natural;
   -- 1 = Norden (-), 2 = Westen (-), 3 = Süden (+), 4 = Osten (+)
   type RichtungenFeindeArray is array (1 .. 4) of Natural;
   RichtungenFeinde : RichtungenFeindeArray;

   KartenfeldAbstand : GlobaleDatentypen.Kartenfeld;   
   
end KIPruefungen;

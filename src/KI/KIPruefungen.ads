pragma SPARK_Mode (On);

with KIRecords, GlobaleRecords, GlobaleDatentypen, GlobaleVariablen, KIDatentypen;
use GlobaleDatentypen, GlobaleRecords;

package KIPruefungen is

   procedure ZielBerechnenGefahr (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebautArray'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen);



   function EinheitenAbstandBerechnen (EinheitEinsRasseNummer, EinheitZweiRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Natural with
     Pre => (EinheitEinsRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebautArray'Range (2) and EinheitEinsRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and EinheitZweiRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebautArray'Range (2) and EinheitZweiRasseNummer.Rasse in GlobaleDatentypen.Rassen);

   function NähesteEigeneStadtSuchen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Richtung : in KIDatentypen.Richtung_Enum) return GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebautArray'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen);

   function NähesteEigeneEinheitSuchen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Richtung : in KIDatentypen.Richtung_Enum) return GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebautArray'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen);
   
private

   Richtung : Natural;

   AbstandKleiner : GlobaleDatentypen.KartenfeldPositiv;

   -- 1 = Norden (-), 2 = Westen (-), 3 = Süden (+), 4 = Osten (+)
   type RichtungenFeindeArray is array (1 .. 4) of Natural;
   RichtungenFeinde : RichtungenFeindeArray;

   KartenfeldAbstand : GlobaleDatentypen.Kartenfeld;

   type KandidatenArray is array (1 .. 3) of GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   Kandidaten : KandidatenArray;

   procedure StadtImNorden (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; StadtNummer : Positive) with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebautArray'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen and StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2));
   
   procedure StadtImSüden (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; StadtNummer : Positive) with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebautArray'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen and StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2));
   
   procedure StadtImWesten (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; StadtNummer : Positive) with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebautArray'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen and StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2));
   
   procedure StadtImOsten (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; StadtNummer : Positive) with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebautArray'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen and StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2));
   
end KIPruefungen;

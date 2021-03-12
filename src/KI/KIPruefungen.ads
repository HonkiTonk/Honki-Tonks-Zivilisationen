pragma SPARK_Mode (On);

with KIRecords, GlobaleRecords, GlobaleDatentypen, GlobaleVariablen, KIDatentypen;
use GlobaleDatentypen, GlobaleRecords;

package KIPruefungen is

   procedure ZielBerechnenGefahr (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));



   function EinheitenAbstandBerechnen (EinheitEinsRasseNummer, EinheitZweiRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Natural with
     Pre => (EinheitEinsRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitEinsRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and EinheitZweiRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitZweiRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitEinsRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitEinsRasseNummer.Rasse) = 2)
             and (if EinheitZweiRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitZweiRasseNummer.Rasse) = 2));

   function NähesteEigeneStadtSuchen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; RichtungExtern : in KIDatentypen.Richtung_Enum) return GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   function NähesteEigeneEinheitSuchen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; RichtungExtern : in KIDatentypen.Richtung_Enum) return GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));
   
private

   Richtung : Natural;

   AbstandKleiner : GlobaleDatentypen.KartenfeldPositiv;

   -- 1 = Norden (-), 2 = Westen (-), 3 = Süden (+), 4 = Osten (+)
   type RichtungenFeindeArray is array (1 .. 4) of Natural;
   RichtungenFeinde : RichtungenFeindeArray;

   KartenfeldAbstand : GlobaleDatentypen.Kartenfeld;

   type KandidatenArray is array (1 .. 3) of GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   Kandidaten : KandidatenArray;

   procedure StadtImNorden (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; StadtNummer : in GlobaleDatentypen.MaximaleStädte) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));
   
   procedure StadtImSüden (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; StadtNummer : in GlobaleDatentypen.MaximaleStädte) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));
   
   procedure StadtImWesten (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; StadtNummer : in GlobaleDatentypen.MaximaleStädte) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));
   
   procedure StadtImOsten (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; StadtNummer : in GlobaleDatentypen.MaximaleStädte) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));
   
end KIPruefungen;

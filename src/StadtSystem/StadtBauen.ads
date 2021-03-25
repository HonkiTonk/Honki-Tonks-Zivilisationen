pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package StadtBauen is

   procedure StadtEntfernen (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= 0));



   function StadtBauen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0));

   function StadtBauenPrüfen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0));

   function ErweitertesStadtBauenPrüfen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0));

private

   BauMöglich : Boolean;

   Stadtart : GlobaleDatentypen.StadtID;

   StadtNummer : GlobaleDatentypen.MaximaleStädte;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

   function HauptstadtPrüfen (RasseExtern : in GlobaleDatentypen.Rassen) return GlobaleDatentypen.StadtID with
     Post => (HauptstadtPrüfen'Result <= 2);

end StadtBauen;

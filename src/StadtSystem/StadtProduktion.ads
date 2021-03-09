pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package StadtProduktion is

   procedure StadtProduktionPrüfen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer <= GlobaleVariablen.StadtGebaut'Last (2) and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0));

private

   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;

   NahrungsverbrauchEinwohnerMultiplikator : GlobaleDatentypen.GesamtproduktionStadt;   
   RessourcenverbrauchKorruptionMultiplikator : GlobaleDatentypen.GesamtproduktionStadt;
   GeldverbrauchKorruptionMultiplikator : GlobaleDatentypen.GesamtproduktionStadt;
   ForschungsverbrauchKorruptionMultiplikator : GlobaleDatentypen.GesamtproduktionStadt;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   
   procedure StadtProduktionPrüfenBerechnung (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0));

   procedure WeitereNahrungsproduktionÄnderungen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0));

   procedure WeitereProduktionrateÄnderungen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0));

   procedure WeitereGeldgewinnungÄnderungen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0));

   procedure WeitereForschungsrateÄnderungen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0));

end StadtProduktion;

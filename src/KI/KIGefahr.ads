pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen, GlobaleVariablen;

package KIGefahr is

   function KIGefahr (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

private

   BestehtGefahr : Boolean;

   EinheitTyp : GlobaleDatentypen.EinheitenTyp;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

   EinheitRassePlatznummer : GlobaleRecords.RassePlatznummerRecord;

   function Unbewaffnet (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   function Nahkämpfer (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   function Fernkämpfer (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

end KIGefahr;

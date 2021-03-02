pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package StadtBauen is

   function StadtBauen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen and GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0);

   function StadtBauenPrüfen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen and GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0);

   function ErweitertesStadtBauenPrüfen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen and GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0);

private

   BauMöglich : Boolean;

   Stadtart : GlobaleDatentypen.StadtID;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

end StadtBauen;

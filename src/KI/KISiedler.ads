pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package KISiedler is

   procedure KISiedler (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

private
   
   StadtErfolgreichGebaut : Boolean;
   Gefahr : Boolean;
   UmgebungVerbessern : Boolean;
   GehStadtBauen : Boolean;
   Verbessern : Boolean;
   Vernichten : Boolean;

   function StadtUmgebungVerbessern (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   function NeueStadtBauenGehen (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   function StadtBauenPrüfung (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean  with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

end KISiedler;

pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package KISiedler is

   procedure KISiedler (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

private
   
   StadtErfolgreichGebaut : Boolean;
   Gefahr : Boolean;
   UmgebungVerbessern : Boolean;
   GehStadtBauen : Boolean;
   Verbessern : Boolean;
   Vernichten : Boolean;

   function StadtUmgebungVerbessern (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   function NeueStadtBauenGehen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   function StadtBauenPrüfung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean  with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

end KISiedler;

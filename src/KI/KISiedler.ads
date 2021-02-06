pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KISiedler is

   procedure KISiedler (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

private
   
   StadtErfolgreichGebaut : Boolean;
   Gefahr : Boolean;
   UmgebungVerbessern : Boolean;
   GehStadtBauen : Boolean;
   Verbessern : Boolean;
   Vernichten : Boolean;

   function StadtUmgebungVerbessern (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   function NeueStadtBauenGehen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

end KISiedler;

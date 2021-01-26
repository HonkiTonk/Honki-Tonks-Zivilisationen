with GlobaleDatentypen, GlobaleVariablen, KIBewegung, Karten, InDerStadt, EinheitenDatenbank, KIGefahr, KIEinheitVerbessernOderVernichten;
use GlobaleDatentypen;

package KISiedler is

   procedure KISiedler (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive);

private
   
   StadtErfolgreichGebaut : Boolean;
   Gefahr : Boolean;
   UmgebungVerbessern : Boolean;
   GehStadtBauen : Boolean;
   Verbessern : Boolean;
   Vernichten : Boolean;

   function StadtUmgebungVerbessern (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean;
   function NeueStadtBauenGehen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean;

end KISiedler;

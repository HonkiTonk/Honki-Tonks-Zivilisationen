with GlobaleVariablen, GlobaleDatentypen, EinheitenDatenbank, InDerStadt, KISiedler, KINahkampfLandEinheit, KIFernkampfLandEinheit, KINahkampfSeeEinheit, KIFernkampfSeeEinheit, KINahkampfLuftEinheit, KIFernkampfLuftEinheit;
use GlobaleDatentypen;

package KI is

   procedure KI (RasseExtern : in GlobaleDatentypen.Rassen);

private

   procedure KIAKtivitätEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive);
   procedure KIAktivitätStadt (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);

end KI;

pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

package ImSpiel is

   function ImSpiel
     return Integer
     with
       Post => (ImSpiel'Result in -1 .. 0);

private

   LadenErfolgreich : Boolean;

   AktuellerBefehlSpieler : Integer;
   RückgabeWert : Integer;
   RückgabeOptionen : Integer;

   procedure BerechnungenNachZugendeAllerSpieler;

   function MenschlicherSpieler
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return Integer;

end ImSpiel;

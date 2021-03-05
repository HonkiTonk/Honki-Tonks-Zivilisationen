pragma SPARK_Mode (On);

package ImSpiel is

   function ImSpiel return Integer with
     Post => (ImSpiel'Result in -1 .. 0);

private

   LadenErfolgreich : Boolean;

   AktuellerBefehl : Integer;
   RückgabeOptionen : Integer;

   procedure BerechnungenNachZugendeAllerSpieler;

end ImSpiel;

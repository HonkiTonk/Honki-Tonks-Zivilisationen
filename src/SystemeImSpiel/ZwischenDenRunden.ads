pragma SPARK_Mode (On);

package ZwischenDenRunden is

   WeiterSpielen : Boolean := False;

   function BerechnungenNachZugendeAllerSpieler
     return Boolean;

private

   procedure GeldForschungMengeSetzen;

end ZwischenDenRunden;

pragma SPARK_Mode (On);

package ZwischenDenRunden is

   WeiterSpielen : Boolean := False;

   function BerechnungenNachZugendeAllerSpieler
     return Boolean;

private

   KIVorhanden : Boolean;

   procedure GeldForschungMengeSetzen;

end ZwischenDenRunden;

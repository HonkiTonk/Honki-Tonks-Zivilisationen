pragma SPARK_Mode (On);

package ZwischenDenRunden is

   function BerechnungenNachZugendeAllerSpieler
     return Boolean;

private

   KIVorhanden : Boolean;

   procedure GeldForschungMengeSetzen;

end ZwischenDenRunden;

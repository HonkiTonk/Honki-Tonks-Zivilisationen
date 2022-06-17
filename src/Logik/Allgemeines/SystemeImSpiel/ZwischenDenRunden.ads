pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package ZwischenDenRunden is

   function BerechnungenNachZugendeAllerSpieler
     return Boolean;

private

   procedure RundenanzahlSetzen;
   procedure DiplomatieÄnderung;
   procedure GeldForschungMengeSetzen;



   function NachSiegWeiterspielen
     return Boolean;

end ZwischenDenRunden;

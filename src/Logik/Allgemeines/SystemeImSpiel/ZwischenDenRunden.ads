pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package ZwischenDenRunden is

   function BerechnungenNachZugendeAllerSpieler
     return Boolean;

private

   KIVorhanden : Boolean;

   procedure RundenAnzahlSetzen;
   procedure EinzelneKIZeitenAnzeigen;
   procedure DiplomatieÄnderung;
   procedure GeldForschungMengeSetzen;
   procedure GesamteZeitenAnzeigen;



   function NachSiegWeiterspielen
     return Boolean;

end ZwischenDenRunden;

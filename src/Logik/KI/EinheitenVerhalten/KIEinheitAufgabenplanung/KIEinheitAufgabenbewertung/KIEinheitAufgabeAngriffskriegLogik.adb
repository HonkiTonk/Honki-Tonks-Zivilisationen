pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIKonstanten;

package body KIEinheitAufgabeAngriffskriegLogik is

   function AngriffskriegVorbereiten
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      return KIKonstanten.UnmöglichAufgabenbewertung;
      
   end AngriffskriegVorbereiten;

end KIEinheitAufgabeAngriffskriegLogik;

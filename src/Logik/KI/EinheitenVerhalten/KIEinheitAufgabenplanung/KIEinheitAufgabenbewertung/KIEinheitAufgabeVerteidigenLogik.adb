pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIKonstanten;

package body KIEinheitAufgabeVerteidigenLogik is

   function Verteidigen
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      return KIKonstanten.UnmöglichAufgabenbewertung;
      
   end Verteidigen;

end KIEinheitAufgabeVerteidigenLogik;

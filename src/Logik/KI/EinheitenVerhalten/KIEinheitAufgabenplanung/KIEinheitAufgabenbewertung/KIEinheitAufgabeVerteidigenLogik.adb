pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen; use KIDatentypen;

package body KIEinheitAufgabeVerteidigenLogik is

   function Verteidigen
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      return -1;
      
   end Verteidigen;

end KIEinheitAufgabeVerteidigenLogik;

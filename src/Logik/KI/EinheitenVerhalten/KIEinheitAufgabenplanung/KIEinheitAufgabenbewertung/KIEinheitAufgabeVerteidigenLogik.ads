pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeVerteidigenLogik is
   pragma Elaborate_Body;

   function Verteidigen
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabeVerteidigenLogik;

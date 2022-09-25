pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeVerteidigenLogik is

   function Verteidigen
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabeVerteidigenLogik;

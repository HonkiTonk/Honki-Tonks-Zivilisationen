pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeVerteidigen is

   function Verteidigen
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabeVerteidigen;

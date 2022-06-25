pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeErkunden is

   function Erkunden
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabeErkunden;

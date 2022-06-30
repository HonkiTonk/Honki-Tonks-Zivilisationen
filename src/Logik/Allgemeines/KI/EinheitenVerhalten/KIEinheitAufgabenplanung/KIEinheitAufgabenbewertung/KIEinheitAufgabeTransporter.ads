pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeTransporter is

   function AbholungAbwarten
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabeTransporter;

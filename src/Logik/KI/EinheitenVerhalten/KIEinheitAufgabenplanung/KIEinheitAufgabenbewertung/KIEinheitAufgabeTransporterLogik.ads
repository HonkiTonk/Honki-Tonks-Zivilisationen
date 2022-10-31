pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeTransporterLogik is
   pragma Elaborate_Body;

   function AbholungAbwarten
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabeTransporterLogik;

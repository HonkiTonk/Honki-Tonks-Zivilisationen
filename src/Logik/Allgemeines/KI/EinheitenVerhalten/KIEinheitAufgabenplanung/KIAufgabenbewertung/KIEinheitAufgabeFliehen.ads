pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeFliehen is

   function Fliehen
     return KIDatentypen.AufgabenWichtigkeit;

end KIEinheitAufgabeFliehen;

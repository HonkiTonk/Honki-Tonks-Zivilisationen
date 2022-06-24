pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeBefestigen is

   function SichBefestigen
     return KIDatentypen.AufgabenWichtigkeit;

end KIEinheitAufgabeBefestigen;

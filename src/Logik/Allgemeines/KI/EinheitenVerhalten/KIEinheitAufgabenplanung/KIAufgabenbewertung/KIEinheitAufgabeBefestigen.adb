pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KIEinheitAufgabeBefestigen is

   function SichBefestigen
     return KIDatentypen.AufgabenWichtigkeit
   is begin
      
      return 0;
      
   end SichBefestigen;

end KIEinheitAufgabeBefestigen;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KIEinheitAufgabeErkunden is

   function Erkunden
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      return 2;
      
   end Erkunden;

end KIEinheitAufgabeErkunden;

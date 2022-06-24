pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KIEinheitAufgabePluendern is

   function StadtUmgebungZerstören
     return KIDatentypen.AufgabenWichtigkeit
   is begin
      
      return 0;
      
   end StadtUmgebungZerstören;

end KIEinheitAufgabePluendern;

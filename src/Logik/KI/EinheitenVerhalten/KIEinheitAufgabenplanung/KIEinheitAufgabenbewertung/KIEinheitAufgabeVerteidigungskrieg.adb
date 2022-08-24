pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen; use KIDatentypen;

package body KIEinheitAufgabeVerteidigungskrieg is

   function VerteidigungskriegVorbereiten
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      return -1;
      
   end VerteidigungskriegVorbereiten;

end KIEinheitAufgabeVerteidigungskrieg;

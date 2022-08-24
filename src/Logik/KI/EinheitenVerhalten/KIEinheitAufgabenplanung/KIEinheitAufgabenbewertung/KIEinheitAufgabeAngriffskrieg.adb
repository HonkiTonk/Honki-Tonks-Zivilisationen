pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen; use KIDatentypen;

package body KIEinheitAufgabeAngriffskrieg is

   function AngriffskriegVorbereiten
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      return -1;
      
   end AngriffskriegVorbereiten;

end KIEinheitAufgabeAngriffskrieg;

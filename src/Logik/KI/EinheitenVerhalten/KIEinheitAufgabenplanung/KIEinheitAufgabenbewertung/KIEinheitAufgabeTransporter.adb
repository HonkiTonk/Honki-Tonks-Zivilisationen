pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen; use KIDatentypen;

package body KIEinheitAufgabeTransporter is

   function AbholungAbwarten
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      return -1;
      
   end AbholungAbwarten;

end KIEinheitAufgabeTransporter;

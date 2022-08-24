pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KIEinheitFestlegenTransporter is

   function AbholungAbwarten
     return Boolean
   is begin
      
      return False;
      
   end AbholungAbwarten;

end KIEinheitFestlegenTransporter;

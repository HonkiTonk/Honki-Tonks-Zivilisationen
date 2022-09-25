pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KIEinheitFestlegenTransporterLogik is

   function AbholungAbwarten
     return Boolean
   is begin
      
      return False;
      
   end AbholungAbwarten;

end KIEinheitFestlegenTransporterLogik;

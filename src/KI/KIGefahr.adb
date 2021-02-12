pragma SPARK_Mode (On);

package body KIGefahr is

   -- Aufteilen nach Unbewaffnet, Fernkämpfer und Nahkämpfer?
   function KIGefahr (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean is
   begin
      
      return False;
      
   end KIGefahr;



   function Unbewaffnet return Boolean is
   begin
      
      return True;
      
   end Unbewaffnet;
   
   
   
   function Nahkämpfer return Boolean is
   begin
      
      return True;
      
   end Nahkämpfer;
   
   
   
   function Fernkämpfer return Boolean is
   begin
      
      return True;
      
   end Fernkämpfer;

end KIGefahr;

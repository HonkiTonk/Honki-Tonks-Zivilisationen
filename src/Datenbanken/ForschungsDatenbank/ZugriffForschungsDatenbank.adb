pragma SPARK_Mode (On);

with ForschungsDatenbank;

with LesenGlobaleVariablen;

package body ZugriffForschungsDatenbank is

   -- Ohne ID
   function PreisOhneID
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return 1;
        
   end PreisOhneID;
   -- Ohne ID
   
   -- Mit ID
   
   -- Mit ID

end ZugriffForschungsDatenbank;

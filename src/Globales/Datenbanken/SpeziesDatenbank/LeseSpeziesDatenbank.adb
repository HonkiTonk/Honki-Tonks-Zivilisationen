with SpeziesDatenbank;

package body LeseSpeziesDatenbank is

   function SpeziesAggressivität
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Speziesverhalten
   is begin
      
      return SpeziesDatenbank.Speziesliste (SpeziesExtern).Aggressivität;
        
   end SpeziesAggressivität;
   
   
   
   function SpeziesExpansion
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Speziesverhalten
   is begin
      
      return SpeziesDatenbank.Speziesliste (SpeziesExtern).Expansion;
        
   end SpeziesExpansion;
   
   
   
   function SpeziesWissenschaft
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Speziesverhalten
   is begin
      
      return SpeziesDatenbank.Speziesliste (SpeziesExtern).Wissenschaft;
        
   end SpeziesWissenschaft;
   
   
   
   function SpeziesProduktion
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Speziesverhalten
   is begin
      
      return SpeziesDatenbank.Speziesliste (SpeziesExtern).Produktion;
        
   end SpeziesProduktion;
   
   
   
   function SpeziesWirtschaft
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Speziesverhalten
   is begin
      
      return SpeziesDatenbank.Speziesliste (SpeziesExtern).Wirtschaft;
        
   end SpeziesWirtschaft;
   
   
   
   function SpeziesBewirtschaftung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Speziesverhalten
   is begin
      
      return SpeziesDatenbank.Speziesliste (SpeziesExtern).Bewirtschaftung;
        
   end SpeziesBewirtschaftung;
   
   
   
   function SpeziesGültigeStaatsform
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StaatsformExtern : SpeziesDatentypen.Staatsform_Enum)
      return Boolean
   is
      use type SpeziesDatentypen.Staatsform_Enum;
   begin
            
      StaatsformenSchleife:
      for StaatsformSchleifenwert in SpeziesDatentypen.StaatsformenArray'Range loop
         
         if
           SpeziesDatenbank.Speziesliste (SpeziesExtern).Staatsformen (StaatsformSchleifenwert) = StaatsformExtern
         then
            return True;
         
         else
            null;
         end if;
         
      end loop StaatsformenSchleife;
      
      return False;
        
   end SpeziesGültigeStaatsform;

end LeseSpeziesDatenbank;

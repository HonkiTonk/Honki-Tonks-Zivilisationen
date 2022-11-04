pragma Warnings (Off, "*array aggregate*");

with RassenDatenbank;

package body LeseRassenDatenbank is

   function RassenAggressivität
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.Rassenliste (RasseExtern).Aggressivität;
        
   end RassenAggressivität;
   
   
   
   function RassenExpansion
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.Rassenliste (RasseExtern).Expansion;
        
   end RassenExpansion;
   
   
   
   function RassenWissenschaft
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.Rassenliste (RasseExtern).Wissenschaft;
        
   end RassenWissenschaft;
   
   
   
   function RassenProduktion
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.Rassenliste (RasseExtern).Produktion;
        
   end RassenProduktion;
   
   
   
   function RassenWirtschaft
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.Rassenliste (RasseExtern).Wirtschaft;
        
   end RassenWirtschaft;
   
   
   
   function RassenBewirtschaftung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.Rassenliste (RasseExtern).Bewirtschaftung;
        
   end RassenBewirtschaftung;
   
   
   
   function RassenGültigeStaatsform
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StaatsformExtern : RassenDatentypen.Staatsform_Enum)
      return Boolean
   is begin
            
      StaatsformenSchleife:
      for StaatsformSchleifenwert in RassenDatentypen.StaatsformenArray'Range loop
         
         if
           RassenDatenbank.Rassenliste (RasseExtern).Staatsformen (StaatsformSchleifenwert) = StaatsformExtern
         then
            return True;
         
         else
            null;
         end if;
         
      end loop StaatsformenSchleife;
      
      return False;
        
   end RassenGültigeStaatsform;

end LeseRassenDatenbank;

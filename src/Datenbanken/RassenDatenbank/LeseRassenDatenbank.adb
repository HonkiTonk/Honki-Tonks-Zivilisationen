pragma SPARK_Mode (On);

with RassenDatenbank;

package body LeseRassenDatenbank is

   function RassenAggressivität
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.RassenListe (RasseExtern).Aggressivität;
        
   end RassenAggressivität;
   
   
   
   function RassenExpansion
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.RassenListe (RasseExtern).Expansion;
        
   end RassenExpansion;
   
   
   
   function RassenWissenschaft
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.RassenListe (RasseExtern).Wissenschaft;
        
   end RassenWissenschaft;
   
   
   
   function RassenProduktion
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.RassenListe (RasseExtern).Produktion;
        
   end RassenProduktion;
   
   
   
   function RassenWirtschaft
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.RassenListe (RasseExtern).Wirtschaft;
        
   end RassenWirtschaft;
   
   
   
   function RassenBewirtschaftung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return RassenDatenbank.RassenListe (RasseExtern).Bewirtschaftung;
        
   end RassenBewirtschaftung;
   
   
   
   function RassenGültigeStaatsform
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      StaatsformExtern : GlobaleDatentypen.Staatsform_Enum)
      return Boolean
   is begin
            
      StaatsformenSchleife:
      for StaatsformSchleifenwert in GlobaleDatentypen.StaatsformenArray'Range loop
         
         if
           RassenDatenbank.RassenListe (RasseExtern).GültigeStaatsformen (StaatsformSchleifenwert) = StaatsformExtern
         then
            return True;
         
         else
            null;
         end if;
         
      end loop StaatsformenSchleife;
      
      return False;
        
   end RassenGültigeStaatsform;

end LeseRassenDatenbank;

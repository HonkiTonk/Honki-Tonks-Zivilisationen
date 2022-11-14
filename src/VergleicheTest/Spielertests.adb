with SpielVariablen;

package body Spielertests is
   
   function BeliebigeSpielerart
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
      return Boolean
   is
      use type RassenDatentypen.Rassen_Enum;
      use type RassenDatentypen.Spieler_Enum;
   begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung not in RassenDatentypen.Spieler_Belegt_Enum'Range
         then
            null;
            
         else
            return True;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end BeliebigeSpielerart;
   
   

   function MenschlicheSpieler
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
      return Boolean
   is
      use type RassenDatentypen.Rassen_Enum;
      use type RassenDatentypen.Spieler_Enum;
   begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung /= RassenDatentypen.Mensch_Spieler_Enum
         then
            null;
            
         else
            return True;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end MenschlicheSpieler;
   
   
   
   function KISpieler
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
      return Boolean
   is
      use type RassenDatentypen.Rassen_Enum;
      use type RassenDatentypen.Spieler_Enum;
   begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung /= RassenDatentypen.KI_Spieler_Enum
         then
            null;
            
         else
            return True;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end KISpieler;

end Spielertests;

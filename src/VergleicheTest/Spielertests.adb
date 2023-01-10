with LeseSpeziesbelegung;

package body Spielertests is
   
   function BeliebigeSpielerart
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type SpeziesDatentypen.Spieler_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           SpeziesSchleifenwert = SpeziesExtern
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) not in SpeziesDatentypen.Spieler_Belegt_Enum'Range
         then
            null;
            
         else
            return True;
         end if;
         
      end loop SpeziesSchleife;
      
      return False;
      
   end BeliebigeSpielerart;
   
   

   function MenschlicheSpieler
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type SpeziesDatentypen.Spieler_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           SpeziesSchleifenwert = SpeziesExtern
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) /= SpeziesDatentypen.Mensch_Spieler_Enum
         then
            null;
            
         else
            return True;
         end if;
         
      end loop SpeziesSchleife;
      
      return False;
      
   end MenschlicheSpieler;
   
   
   
   function KISpieler
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type SpeziesDatentypen.Spieler_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           SpeziesSchleifenwert = SpeziesExtern
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) /= SpeziesDatentypen.KI_Spieler_Enum
         then
            null;
            
         else
            return True;
         end if;
         
      end loop SpeziesSchleife;
      
      return False;
      
   end KISpieler;

end Spielertests;

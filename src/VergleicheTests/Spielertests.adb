with LeseSpeziesbelegung;

with MeldungssystemHTB1;

package body Spielertests is
   
   function BeliebigeSpielerart
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type SpeziesDatentypen.Spieler_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
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
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
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
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
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
   
   
   
   function AnzahlMenschlicheSpieler
     return Positive
   is begin
      
      VorhandeneMenschen := 0;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Mensch_Spieler_Enum =>
               VorhandeneMenschen := VorhandeneMenschen + 1;
               
            when others =>
               null;
         end case;
         
      end loop SpeziesSchleife;
      
      case
        VorhandeneMenschen
      is
         when SpeziesDatentypen.SpeziesnummernVorhanden'Range =>
            return VorhandeneMenschen;
            
         when others =>
            MeldungssystemHTB1.Logik (MeldungExtern => "Spielertests.AnzahlMenschlicheSpieler: Ungültige Anzahl an Spielern: " & VorhandeneMenschen'Wide_Wide_Image);
            return 1;
      end case;
      
   end AnzahlMenschlicheSpieler;
   
end Spielertests;

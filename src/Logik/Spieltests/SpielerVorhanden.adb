pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

package body SpielerVorhanden is
   
   function BeliebigeSpielerart
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
      return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             SpielVariablen.RassenImSpiel (RasseSchleifenwert) not in Spieler_Belegt_Enum'Range
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
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             SpielVariablen.RassenImSpiel (RasseSchleifenwert) /= RassenDatentypen.Mensch_Spieler_Enum
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
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             SpielVariablen.RassenImSpiel (RasseSchleifenwert) /= RassenDatentypen.KI_Spieler_Enum
         then
            null;
            
         else
            return True;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end KISpieler;

end SpielerVorhanden;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with SpielVariablen;

with LeseWichtiges;

with Enden;

package body SiegBedingungen is

   function SiegBedingungen
     return Boolean
   is begin
      
      case
        SiegBedingungEins
      is
         when True =>
            Enden.EndeEins;
            return True;
            
         when False =>
            null;
      end case;
      
      case
        SiegBedingungZwei
      is
         when True =>
            Enden.EndeEins;
            return True;
            
         when False =>
            null;
      end case;
      
      case
        SiegBedingungDrei
      is
         when True =>
            Enden.EndeEins;
            return True;
            
         when False =>
            null;
      end case;
      
      return False;
      
   end SiegBedingungen;
      
      
      
   function SiegBedingungEins
     return Boolean
   is begin
         
      VorhandeneRassen := 0;
      
      RassenSchleife:
      for RassenSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.RassenImSpiel (RassenSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               VorhandeneRassen := VorhandeneRassen + 1;
         end case;
         
         case
           VorhandeneRassen
         is
            when 0 .. 1 =>
               null;
               
            when others =>
               exit RassenSchleife;
         end case;
         
      end loop RassenSchleife;
      
      case
        VorhandeneRassen
      is
         when 0 =>
            -- Was mache ich denn in diesem Fall? Kann der überhaupt auftreten?
            return True;
            
         when 1 =>
            SonstigeVariablen.Gewonnen := True;
            return True;
            
         when others =>
            return False;
      end case;
      
   end SiegBedingungEins;
   
   
   
   function SiegBedingungZwei
     return Boolean
   is begin
      
      RassenGeldSchleife:
      for RassenGeldSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           SpielVariablen.RassenImSpiel (RassenGeldSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           LeseWichtiges.Geldmenge (RasseExtern => RassenGeldSchleifenwert) = Integer'Last
         then
            SonstigeVariablen.Gewonnen := True;
            return True;
            
         else
            null;
         end if;
         
      end loop RassenGeldSchleife;
      
      return False;
      
   end SiegBedingungZwei;
   
   
   
   function SiegBedingungDrei
     return Boolean
   is begin
      
      case
        SonstigeVariablen.Debug.Sieg
      is
         when False =>
            return False;
            
         when True =>
            SonstigeVariablen.Gewonnen := True;
            return True;
      end case;
         
   end SiegBedingungDrei;

end SiegBedingungen;

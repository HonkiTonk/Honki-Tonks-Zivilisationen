pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

with LeseWichtiges;

with AbspannLogik;
with NachGrafiktask;

package body SiegbedingungenLogik is

   function Siegbedingungen
     return Boolean
   is begin
            
      if
        SiegbedingungEins = True
      then
         Sieg := GrafikDatentypen.Gewonnen_Enum;
      
      elsif
        SiegbedingungZwei = True
      then
         Sieg := GrafikDatentypen.Gewonnen_Enum;
      
      elsif
        SiegbedingungDrei = True
      then
         Sieg := GrafikDatentypen.Gewonnen_Enum;
            
      else
         Sieg := GrafikDatentypen.Gewonnen_Enum;
      end if;
      
      case
        Sieg
      is 
         when GrafikDatentypen.Abspann_Enum'Range =>
            NachGrafiktask.AktuelleRasse := RassenDatentypen.Ekropa_Enum;
            AbspannLogik.Abspann (AbspannExtern => Sieg);
            NachGrafiktask.AktuelleRasse := RassenDatentypen.Keine_Rasse_Enum;
            return True;
            
         when others =>
            return False;
      end case;
      
   end Siegbedingungen;
      
      
      
   function SiegbedingungEins
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
            -- Was mache ich denn in diesem Fall? Kann eventuell im neuen System auftreten, auf True lassen bis ich was besseres für die Enden gebaut habe. äöü
            return True;
            
         when 1 =>
            SpielVariablen.Allgemeines.Gewonnen := True;
            return True;
            
         when others =>
            return False;
      end case;
      
   end SiegbedingungEins;
   
   
   
   function SiegbedingungZwei
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
            SpielVariablen.Allgemeines.Gewonnen := True;
            return True;
            
         else
            null;
         end if;
         
      end loop RassenGeldSchleife;
      
      return False;
      
   end SiegbedingungZwei;
   
   
   
   function SiegbedingungDrei
     return Boolean
   is begin
      
      case
        SpielVariablen.Debug.Sieg
      is
         when False =>
            return False;
            
         when True =>
            SpielVariablen.Allgemeines.Gewonnen := True;
            return True;
      end case;
         
   end SiegbedingungDrei;

end SiegbedingungenLogik;

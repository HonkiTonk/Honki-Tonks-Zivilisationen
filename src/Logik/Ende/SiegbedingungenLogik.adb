pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with WichtigesRecordKonstanten;

with LeseWichtiges;

with AbspannLogik;
with NachGrafiktask;

package body SiegbedingungenLogik is

   function Siegbedingungen
     return SystemDatentypen.Ende_Enum
   is begin
      
      case
        RasseBesiegt
      is
         when False =>
            null;
            
         when True =>
            return SystemDatentypen.Verloren_Enum;
      end case;
            
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
         Sieg := GrafikDatentypen.Leer_Hintergrund_Enum;
      end if;
      
      case
        Sieg
      is 
         when GrafikDatentypen.Abspann_Enum'Range =>
            NachGrafiktask.AktuelleRasse := RassenDatentypen.Ekropa_Enum;
            AbspannLogik.Abspann (AbspannExtern => Sieg);
            NachGrafiktask.AktuelleRasse := RassenDatentypen.Keine_Rasse_Enum;
            return SystemDatentypen.Gewonnen_Enum;
            
         when others =>
            return SystemDatentypen.Leer_Enum;
      end case;
      
   end Siegbedingungen;
   
   
   
   function RasseBesiegt
     return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Besiegt
         is
            when True =>
               if
                 SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung = RassenDatentypen.Mensch_Spieler_Enum
               then
                  SpielVariablen.Rassenbelegung (RasseSchleifenwert) := WichtigesRecordKonstanten.LeerRassenbelegung;
                  return True;
                  
               else
                  SpielVariablen.Rassenbelegung (RasseSchleifenwert) := WichtigesRecordKonstanten.LeerRassenbelegung;
                  return False;
               end if;
           
            when False =>
               null;
         end case;
         
      end loop RassenSchleife;
      
      return False;
      
   end RasseBesiegt;
      
      
      
   function SiegbedingungEins
     return Boolean
   is begin
         
      VorhandeneRassen := 0;
      
      RassenSchleife:
      for RassenSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.Rassenbelegung (RassenSchleifenwert).Belegung
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               VorhandeneRassen := VorhandeneRassen + 1;
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
           SpielVariablen.Rassenbelegung (RassenGeldSchleifenwert).Belegung = RassenDatentypen.Leer_Spieler_Enum
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

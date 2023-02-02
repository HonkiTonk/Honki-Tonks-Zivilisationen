with SpeziesDatentypen;
with WichtigesRecordKonstanten;
with SpeziesKonstanten;

with LeseWichtiges;
with SchreibeAllgemeines;
with LeseSpeziesbelegung;
with SchreibeSpeziesbelegung;

with AbspannLogik;
with NachGrafiktask;

package body SiegbedingungenLogik is

   function Siegbedingungen
     return SystemDatentypen.Ende_Enum
   is
      use type GrafikDatentypen.Spezieshintergrund_Enum;
   begin
      
      case
        SpeziesBesiegt
      is
         when False =>
            null;
            
         when True =>
            return SystemDatentypen.Verloren_Enum;
      end case;
            
      if
        SiegbedingungEins = True
      then
         case
           MenschlicherSpielerVorhanden
         is
            when True =>
               Sieg := GrafikDatentypen.Gewonnen_Enum;
               
            when False =>
               Sieg := GrafikDatentypen.Verloren_Enum;
         end case;
      
      elsif
        SiegbedingungZwei = True
      then
         Sieg := GrafikDatentypen.Gewonnen_Enum;
            
      else
         Sieg := GrafikDatentypen.Leer_Hintergrund_Enum;
      end if;
      
      case
        Sieg
      is 
         when GrafikDatentypen.Abspann_Enum'Range =>
            NachGrafiktask.AktuelleSpezies := SpeziesDatentypen.Ekropa_Enum;
            AbspannLogik.Abspann (AbspannExtern => Sieg);
            NachGrafiktask.AktuelleSpezies := SpeziesKonstanten.LeerSpezies;
            
            if
              Sieg = GrafikDatentypen.Gewonnen_Enum
            then
               return SystemDatentypen.Gewonnen_Enum;
               
            else
               return SystemDatentypen.Verloren_Enum;
            end if;
            
         when others =>
            return SystemDatentypen.Leer_Enum;
      end case;
      
   end Siegbedingungen;
   
   
   
   function SpeziesBesiegt
     return Boolean
   is
      use type SpeziesDatentypen.Spieler_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Besiegt (SpeziesExtern => SpeziesSchleifenwert)
         is
            when True =>
               SchreibeSpeziesbelegung.GanzerEintrag (SpeziesExtern => SpeziesSchleifenwert,
                                                      EintragExtern => WichtigesRecordKonstanten.LeerSpeziesbelegung);
               
               if
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Mensch_Spieler_Enum
               then
                  return True;
                  
               else
                  return False;
               end if;
               
            when False =>
               null;
         end case;
         
      end loop SpeziesSchleife;
      
      return False;
      
   end SpeziesBesiegt;
      
      
      
   function SiegbedingungEins
     return Boolean
   is begin
         
      VorhandeneSpezies := 0;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               VorhandeneSpezies := VorhandeneSpezies + 1;
         end case;
         
      end loop SpeziesSchleife;
      
      case
        VorhandeneSpezies
      is
         when 0 =>
            -- Was mache ich denn in diesem Fall? Kann eventuell im neuen System auftreten, auf True lassen bis ich was besseres für die Enden gebaut habe. äöü
            return True;
            
         when 1 =>
            SchreibeAllgemeines.Gewonnen;
            return True;
            
         when others =>
            return False;
      end case;
      
   end SiegbedingungEins;
   
   
   
   function SiegbedingungZwei
     return Boolean
   is
      use type SpeziesDatentypen.Spieler_Enum;
   begin
      
      SpeziesGeldSchleife:
      for SpeziesGeldSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesGeldSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           LeseWichtiges.Geldmenge (SpeziesExtern => SpeziesGeldSchleifenwert) = Integer'Last
         then
            SchreibeAllgemeines.Gewonnen;
            return True;
            
         else
            null;
         end if;
         
      end loop SpeziesGeldSchleife;
      
      return False;
      
   end SiegbedingungZwei;
   
   
   
   function MenschlicherSpielerVorhanden
     return Boolean
   is
      use type SpeziesDatentypen.Spieler_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
               
         if
           LeseSpeziesbelegung.Besiegt (SpeziesExtern => SpeziesSchleifenwert) = False
           and
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Mensch_Spieler_Enum
         then
            return True;
            
         else
            null;
         end if;
               
      end loop SpeziesSchleife;
            
      return False;
      
   end MenschlicherSpielerVorhanden;
   

end SiegbedingungenLogik;

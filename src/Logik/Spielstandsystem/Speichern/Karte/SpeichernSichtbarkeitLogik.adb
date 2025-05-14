with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SpeziesKonstanten;

with LeseWeltkarte;
with LeseSpeziesbelegung;

package body SpeichernSichtbarkeitLogik is
   
   -- Das woanders reinpacken. äöü
   function SpeziesanzahlErmitteln
     return SpeziesDatentypen.SpeziesnummernVorhanden
   is begin
      
      VorhandeneSpezies := SpeziesKonstanten.LeerSpeziesnummer;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Spieler_Belegt_Enum =>
               VorhandeneSpezies := VorhandeneSpezies + 1;
               
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
         end case;
         
      end loop SpeziesSchleife;
      
      return VorhandeneSpezies;
      
   end SpeziesanzahlErmitteln;
   
   
   
   function Sichtbarkeit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      VorhandeneSpezies := SpeziesKonstanten.LeerSpeziesnummer;
      GesamteSichtbarkeit := LeseWeltkarte.GesamteSichtbarkeit (KoordinatenExtern => KoordinatenExtern);
      
      SichtbarkeitVorhanden := (others => 0);
      AktuelleSichtbarkeit := 1;
      AktuellerBereich := 1;
      
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SichtbarkeitSchleifenwert) in SpeziesDatentypen.Spieler_Belegt_Enum'Range
         then
            case
              GesamteSichtbarkeit (SichtbarkeitSchleifenwert)
            is
               when True =>
                  SichtbarkeitVorhanden (AktuellerBereich) := SichtbarkeitVorhanden (AktuellerBereich) + AktuelleSichtbarkeit;
               
               when False =>
                  null;
            end case;
            
            VorhandeneSpezies := VorhandeneSpezies + 1;
         
            case
              VorhandeneSpezies mod 8
            is
               when 0 =>
                  AktuellerBereich := AktuellerBereich + 1;
                  AktuelleSichtbarkeit := 1;
               
               when others =>
                  AktuelleSichtbarkeit := AktuelleSichtbarkeit * 2;
            end case;
            
         else
            null;
         end if;
         
      end loop SichtbarkeitSchleife;
      
      SpeichernSchleife:
      for SpeichernSchleifenwert in reverse SichtbarkeitArray'Range loop
         
         case
           SichtbarkeitVorhanden (AktuellerBereich)
         is
            when 0 =>
               null;
               
            when others =>
               SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                                    SichtbarkeitVorhanden (SpeichernSchleifenwert));
         end case;
         
      end loop SpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSichtbarkeitLogik.Sichtbarkeit: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Sichtbarkeit;

end SpeichernSichtbarkeitLogik;

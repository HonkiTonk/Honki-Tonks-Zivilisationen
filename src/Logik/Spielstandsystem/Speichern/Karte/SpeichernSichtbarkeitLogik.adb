with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SpeziesKonstanten;

with LeseWeltkarte;
with LeseSpeziesbelegung;

package body SpeichernSichtbarkeitLogik is
   
   function Sichtbarkeit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.Speziesnummern;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      case
        VorhandeneSpeziesExtern
      is
         when 0 =>
            return False;
            
         when others =>
            VorhandeneSpezies := SpeziesKonstanten.LeerSpeziesnummer;
            GesamteSichtbarkeit := LeseWeltkarte.GesamteSichtbarkeit (KoordinatenExtern => KoordinatenExtern);
      
            SichtbarkeitVorhanden := 0;
            AktuelleSichtbarkeit := 1;
      end case;
      
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SichtbarkeitSchleifenwert) in SpeziesDatentypen.Spieler_Belegt_Enum'Range
         then
            case
              GesamteSichtbarkeit (SichtbarkeitSchleifenwert)
            is
               when True =>
                  SichtbarkeitVorhanden := SichtbarkeitVorhanden + AktuelleSichtbarkeit;
               
               when False =>
                  null;
            end case;
            
            VorhandeneSpezies := VorhandeneSpezies + 1;
            
            if
              VorhandeneSpezies = VorhandeneSpeziesExtern
            then
               SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                                    SichtbarkeitVorhanden);
               exit SichtbarkeitSchleife;
         
            elsif
              VorhandeneSpezies mod 8 = 0
            then
               SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                                    SichtbarkeitVorhanden);
               SichtbarkeitVorhanden := 0;
               AktuelleSichtbarkeit := 1;
                  
            else
               AktuelleSichtbarkeit := AktuelleSichtbarkeit * 2;
            end if;
            
         else
            null;
         end if;
         
      end loop SichtbarkeitSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSichtbarkeitLogik.Sichtbarkeit: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Sichtbarkeit;

end SpeichernSichtbarkeitLogik;

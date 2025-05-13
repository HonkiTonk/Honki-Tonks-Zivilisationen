with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SpeziesKonstanten;

with LeseWeltkarte;

package body SpeichernSichtbarkeitLogik is
   
   function Sichtbarkeit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypen.EinByte;
   begin
      
      GesamteSichtbarkeit := LeseWeltkarte.GesamteSichtbarkeit (KoordinatenExtern => KoordinatenExtern);
      
      BereichSchleife:
      for BereichSchleifenwert in SpeziesKonstanten.SpeziesanfangLadenSpeichernArray'Range loop
         
         SichtbarkeitVorhanden := 0;
         AktuelleSichtbarkeit := 1;
      
         SichtbarkeitSchleife:
         for SichtbarkeitSchleifenwert in SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert) .. SpeziesKonstanten.SpeziesendeSpeichernLaden (BereichSchleifenwert) loop
         
            case
              GesamteSichtbarkeit (SichtbarkeitSchleifenwert)
            is
               when True =>
                  SichtbarkeitVorhanden := SichtbarkeitVorhanden + AktuelleSichtbarkeit;
               
               when False =>
                  null;
            end case;
            
            AktuelleSichtbarkeit := AktuelleSichtbarkeit * 2;
            
         end loop SichtbarkeitSchleife;
      
         SystemDatentypen.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                         SichtbarkeitVorhanden);
         
      end loop BereichSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSichtbarkeitLogik.Sichtbarkeit: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Sichtbarkeit;
   
   
   
   function SpeziesanzahlErmitteln
     return SpeziesDatentypen.SpeziesnummernVorhanden
   is begin
      
      return 1;
      
   end SpeziesanzahlErmitteln;
   
   
   
   function AchtSpezies
     return Boolean
   is begin
      
      return True;
      
   end AchtSpezies;
   
   
   
   function SechzehnSpezies
     return Boolean
   is begin
      
      return True;
      
   end SechzehnSpezies;
   
   
   
   function AchtzehnSpezies
     return Boolean
   is begin
      
      return True;
      
   end AchtzehnSpezies;

end SpeichernSichtbarkeitLogik;

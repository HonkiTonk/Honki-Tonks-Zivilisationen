with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with EinheitenRecords;
with EinheitenKonstanten;

with LeseEinheitenGebaut;
with LeseGrenzen;

package body SpeichernEinheitenLogik is

   function Einheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
            
      VorhandeneEinheiten := EinheitenKonstanten.LeerNummer;
      
      AnzahlEinheitenSchleife:
      for AnzahlEinheitenSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, AnzahlEinheitenSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               exit AnzahlEinheitenSchleife;
               
            when others =>
               VorhandeneEinheiten := AnzahlEinheitenSchleifenwert;
         end case;
         
      end loop AnzahlEinheitenSchleife;
      
      EinheitenDatentypen.Einheitenbereich'Write (Stream (File => DateiSpeichernExtern),
                                                  VorhandeneEinheiten);
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. VorhandeneEinheiten loop
                  
         EinheitenRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernExtern),
                                                       LeseEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
         
      end loop EinheitenSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernEinheitenLogik.Einheiten: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Einheiten;

end SpeichernEinheitenLogik;

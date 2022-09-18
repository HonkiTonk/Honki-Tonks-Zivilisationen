pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Characters.Conversions; use Ada.Characters.Conversions;

with VerzeichnisKonstanten;
with TastenbelegungDatentypen;
with SystemKonstanten;

with MausauswahlLogik;
with TasteneingabeLogik;
with NachGrafiktask;

-- Reicht da eine Liste oder muss ich eine Variante für Laden und eine für Speichern einbauen? äöü
package body SpielstandlisteLogik is

   function Spielstandliste
     return SpielstandlisteRecord
   is begin
      
      MehrereSeiten := False;
      EtwasEingetragen := False;
      Spielstand := (others => TextKonstanten.LeerUnboundedString);
      
      ObersteSchleife:
      loop
         
         Start_Search (Search    => Suche,
                       Directory => VerzeichnisKonstanten.Spielstand,
                       Pattern   => "",
                       Filter    => (Ordinary_File => True,
                                     others => False));
      
         MittelSchleife:
         loop
            SpeicherdateiSchleife:
            for SpeicherdateiSchleifenwert in SpielstandArray'Range loop
               
               case
                 More_Entries (Search => Suche)
               is
                  when False =>
                     exit SpeicherdateiSchleife;
                     
                  when True =>
                     EtwasEingetragen := True;
                     Get_Next_Entry (Search          => Suche,
                                     Directory_Entry => Spielstanddatei);
               end case;
               
               Spielstand (SpeicherdateiSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => To_Wide_Wide_String (Item => Simple_Name (Directory_Entry => Spielstanddatei)));
               
               case
                 SpeicherdateiSchleifenwert
               is
                  when SpielstandArray'Last =>
                     MehrereSeiten := True;
                     
                  when others =>
                     null;
               end case;
                        
            end loop SpeicherdateiSchleife;
            
            case
              EtwasEingetragen
            is
               when False =>
                  return (RueckgabeDatentypen.Auswahl_Null_Enum, TextKonstanten.LeerUnboundedString);
              
               when True =>
                  AktuelleAuswahl := Mausauswahl;
                  
                  exit ObersteSchleife;
            end case;
            
         end loop MittelSchleife;
      end loop ObersteSchleife;
      
      return (RueckgabeDatentypen.Auswahl_Eins_Enum, TextKonstanten.LeerUnboundedString);
      
   end Spielstandliste;
   
   
   
   function Mausauswahl
     return Natural
   is begin
      
      AuswahlSchleife:
      loop
      
         AktuelleAuswahl := MausauswahlLogik.SpeichernLaden;
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := AktuelleAuswahl;
         
         case
           TasteneingabeLogik.Tastenwert
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = SystemKonstanten.LeerAuswahl
               then
                  null;
                  
               else
                  NachGrafiktask.AktuelleAuswahl.AuswahlEins := SystemKonstanten.LeerAuswahl;
                  return AktuelleAuswahl;
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               return 0;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end Mausauswahl;

end SpielstandlisteLogik;

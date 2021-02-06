pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with Anzeige, GlobaleVariablen;

package body Auswahl is

   function AuswahlSprache return Unbounded_Wide_Wide_String is
   begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      for A in GlobaleVariablen.TexteEinlesenNeu'Range (2) loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (0, A)) = "|" then
            exit;
            
         else
            Ende := A;
         end if;
         
      end loop;

      AktuelleAuswahl := 1;
      
      AuswahlSchleife:
      loop         

         Put_Line (Item => "Sprache auswählen:");
         Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                             AktuelleAuswahl    => 0,
                             FrageDatei         => 0,
                             FrageZeile         => 0,
                             TextDatei          => 0,
                             ErsteZeile         => 0,
                             LetzteZeile        => 0);        
         
         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is               
            when 'w' | '8' => 
               if AktuelleAuswahl = GlobaleVariablen.TexteEinlesenNeu'First (2) then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if AktuelleAuswahl = Ende then
                  AktuelleAuswahl := GlobaleVariablen.TexteEinlesenNeu'First (2);
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 'e' | '5' =>    
               Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
               return GlobaleVariablen.TexteEinlesenNeu (0, AktuelleAuswahl);
                     
            when others =>
               null;                    
         end case;

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");
         
      end loop AuswahlSchleife;
      
   end AuswahlSprache;




   function AuswahlNeu (AuswahlOderAnzeige : in Boolean; FrageDatei, FrageZeile, TextDatei, ErsteZeile, LetzteZeile : in Natural) return Integer is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");    
      
      case AuswahlOderAnzeige is
         when True =>
            Anfang := ErsteZeile;
            Ende := LetzteZeile;
            AktuelleAuswahl := ErsteZeile;
               
         when False => -- Wenn nur Text angezeigt werden soll
            Anzeige.AnzeigeNeu (AuswahlOderAnzeige => AuswahlOderAnzeige,
                                AktuelleAuswahl    => AktuelleAuswahl,
                                FrageDatei         => FrageDatei,
                                FrageZeile         => FrageZeile,
                                TextDatei          => TextDatei,
                                ErsteZeile         => ErsteZeile,
                                LetzteZeile        => LetzteZeile);
            return 1;
      end case;

      AuswahlSchleife:
      loop         
                        
         case FrageDatei is
            when 0 =>
               null;
            
            when others => -- Wenn Frage benötigt wird hierüber ausgeben
               Put_Line (To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (FrageDatei, FrageZeile)));
         end case;

         case TextDatei is
            when 0 =>
               null;
            
            when others => -- Wenn Text benötigt wird hierüber ausgegeben
               Anzeige.AnzeigeNeu (AuswahlOderAnzeige => AuswahlOderAnzeige,
                                   AktuelleAuswahl    => AktuelleAuswahl,
                                   FrageDatei         => FrageDatei,
                                   FrageZeile         => FrageZeile,
                                   TextDatei          => TextDatei,
                                   ErsteZeile         => ErsteZeile,
                                   LetzteZeile        => LetzteZeile);
         end case;

         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is               
            when 'w' | '8' => 
               if AktuelleAuswahl = Anfang then
                  AktuelleAuswahl := Ende;

               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if AktuelleAuswahl = Ende then
                  AktuelleAuswahl := Anfang;

               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 'e' | '5' =>                  
               if GlobaleVariablen.TexteEinlesenNeu (TextDatei, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 1) then -- Hauptmenü
                  return 0;
                  
               elsif GlobaleVariablen.TexteEinlesenNeu (TextDatei, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 2) then -- Spiel beenden
                  return -1;
                  
               elsif GlobaleVariablen.TexteEinlesenNeu (TextDatei, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 3) then -- Zurück
                  return -2;
                  
               elsif GlobaleVariablen.TexteEinlesenNeu (TextDatei, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 4) then -- Ja
                  return -3;
                  
               elsif GlobaleVariablen.TexteEinlesenNeu (TextDatei, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 5) then -- Nein
                  return -4;

               elsif GlobaleVariablen.TexteEinlesenNeu (TextDatei, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 6) then -- Speichern
                  return 2;

               elsif GlobaleVariablen.TexteEinlesenNeu (TextDatei, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 7) then -- Laden
                  return 3;

               elsif GlobaleVariablen.TexteEinlesenNeu (TextDatei, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 8) then -- Optionen
                  return 4;

               elsif GlobaleVariablen.TexteEinlesenNeu (TextDatei, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 9) then -- Informationen
                  return 5;
                     
               else
                  Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
                  return AktuelleAuswahl - ErsteZeile + 1;
               end if;
                     
            when others =>
               null;                    
         end case;

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");

      end loop AuswahlSchleife;
      
   end AuswahlNeu;

end Auswahl;

pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with Anzeige, GlobaleVariablen;

package body Auswahl is

   function AuswahlSprache return Unbounded_Wide_Wide_String is
   begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      EndeBestimmenSchleife:
      for LetztesEnde in GlobaleVariablen.TexteEinlesenNeuArray'Range (2) loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (0, LetztesEnde)) = "|" then
            exit EndeBestimmenSchleife;
            
         else
            Ende := LetztesEnde;
         end if;
         
      end loop EndeBestimmenSchleife;

      AktuelleAuswahl := 1;
      
      AuswahlSchleife:
      loop         

         Anzeige.AnzeigeMitAuswahlNeu (FrageDatei      => GlobaleDatentypen.Leer,
                                       TextDatei       => GlobaleDatentypen.Leer,
                                       FrageZeile      => 0,
                                       ErsteZeile      => 1,
                                       LetzteZeile     => Ende,
                                       AktuelleAuswahl => AktuelleAuswahl);
         
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



   function Auswahl (FrageDatei, TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; FrageZeile, ErsteZeile, LetzteZeile : in Natural) return Integer is
   begin

      Anfang := ErsteZeile;
      Ende := LetzteZeile;
      AktuelleAuswahl := ErsteZeile;
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      AuswahlSchleife:
      loop
         
         Anzeige.AnzeigeMitAuswahlNeu (FrageDatei      => FrageDatei,
                                       TextDatei       => TextDatei,
                                       FrageZeile      => FrageZeile,
                                       ErsteZeile      => ErsteZeile,
                                       LetzteZeile     => LetzteZeile,
                                       AktuelleAuswahl => AktuelleAuswahl);

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
               if GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 1) then -- Hauptmenü
                  return 0;
                  
               elsif GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 2) then -- Spiel beenden
                  return -1;
                  
               elsif GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 3) then -- Zurück
                  return -2;
                  
               elsif GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 4) then -- Ja
                  return -3;
                  
               elsif GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 5) then -- Nein
                  return -4;

               elsif GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 6) then -- Speichern
                  return 2;

               elsif GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 7) then -- Laden
                  return 3;

               elsif GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 8) then -- Optionen
                  return 4;

               elsif GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 9) then -- Informationen
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
      
   end Auswahl;



   function AuswahlJaNein (FrageZeile : in Positive) return Integer is
   begin
      
      return Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                      TextDatei   => GlobaleDatentypen.Menü_Auswahl,
                      FrageZeile  => FrageZeile,
                      ErsteZeile  => 10,
                      LetzteZeile => 11);
      
   end AuswahlJaNein;

end Auswahl;

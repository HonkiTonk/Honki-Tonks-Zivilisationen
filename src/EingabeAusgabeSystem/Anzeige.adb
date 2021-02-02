with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

package body Anzeige is

   procedure AnzeigeNeu (AuswahlOderAnzeige : in Boolean; AktuelleAuswahl, FrageDatei, FrageZeile, TextDatei, ErsteZeile, LetzteZeile : in Natural) is
   begin
      
      case AuswahlOderAnzeige is
         when True =>
            LängsterText := 1;
      
            TextlängePrüfenSchleife:
            for Zeilen in ErsteZeile .. LetzteZeile loop            
               if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (TextDatei, Zeilen))'Length > LängsterText then
                  LängsterText := To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (TextDatei, Zeilen))'Length;
            
               else
                  null;
               end if;
            end loop TextlängePrüfenSchleife;
      
            AnzeigeSchleife:
            for Zeile in ErsteZeile .. LetzteZeile loop

               if AktuelleAuswahl = Zeile then
                  RahmenTeilEinsSchleife:
                  for TextlängeEins in 1 .. LängsterText loop
                  
                     if TextlängeEins = 1 then
                        Put (Item => "╔");
                        Put (Item => "═");

                     elsif TextlängeEins = LängsterText then                  
                        Put (Item => "═");
                        Put_Line (Item => "╗");
                        Put (Item => "║");
                        Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (TextDatei, Zeile)));

                        for Leer in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (TextDatei, Zeile))'Length loop
                        
                           Put (" ");
                        
                        end loop;
                        Put_Line (Item => "║");
                        Put (Item => "╚");

                     else
                        Put (Item => "═");
                     end if;
               
                  end loop RahmenTeilEinsSchleife;

                  RahmenTeilZweiSchleife:
                  for TextlängeZwei in 1 .. LängsterText loop
               
                     if TextlängeZwei = LängsterText then
                        Put (Item => "═");
                        Put_Line (Item => "╝");
               
                     else
                        Put (Item => "═");
                     end if;
            
                  end loop RahmenTeilZweiSchleife;
         
               else
                  Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (TextDatei, Zeile)));
               end if;
         
            end loop AnzeigeSchleife;
            
         when False =>
            case AktuelleAuswahl is
               when 0 =>
                  Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (TextDatei, ErsteZeile)));
                  
               when others =>
                  Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (TextDatei, ErsteZeile)));
            end case;
      end case;
      
   end AnzeigeNeu;



   procedure EinfacheAnzeige (Mit_Line : in Boolean; Datei, Eintrag : in Positive) is
   begin
      
      case Mit_Line is
         when True =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (Ja (Datei, Eintrag).Zieldatei, Ja (Datei, Eintrag).Zielzeile)));
            
         when False =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (Ja (Datei, Eintrag).Zieldatei, Ja (Datei, Eintrag).Zielzeile)));
      end case;
      
   end EinfacheAnzeige;

   

   procedure AnzeigeStadt (AktuelleAuswahl : in Positive) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for A in GlobaleVariablen.TexteEinlesenNeu'Range (2) loop
         if To_Wide_Wide_String (Source => TextBauen (A).Text) = "|" then
            exit TextlängePrüfenSchleife;
            
         elsif To_Wide_Wide_String (Source => TextBauen (A).Text)'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => TextBauen (A).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for A in GlobaleVariablen.TexteEinlesenNeu'Range (2) loop

         if AktuelleAuswahl = A then
            for B in 1 .. LängsterText loop

               if To_Wide_Wide_String (Source => TextBauen (A).Text) = "|" then
                  exit AnzeigeSchleife;
                  
               elsif B = 1 then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif B = LängsterText then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => TextBauen (A).Text));

                  for Leer in 1 .. LängsterText - To_Wide_Wide_String (Source => TextBauen (A).Text)'Length loop
                        
                     Put (" ");
                        
                  end loop;
                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop;

            for C in 1 .. LängsterText loop
               
               if C = LängsterText then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop;
         
         else
            if To_Wide_Wide_String (Source => TextBauen (A).Text) = "|" then
               exit AnzeigeSchleife; 
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => TextBauen (A).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeStadt;



   procedure AnzeigeForschung (AktuelleAuswahl : in Positive) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for A in GlobaleVariablen.TexteEinlesenNeu'Range (2) loop
         if To_Wide_Wide_String (Source => TextForschung (A).Text) = "|" then
            exit TextlängePrüfenSchleife;
            
         elsif To_Wide_Wide_String (Source => TextForschung (A).Text)'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => TextForschung (A).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for A in GlobaleVariablen.TexteEinlesenNeu'Range (2) loop

         if AktuelleAuswahl = A then
            for B in 1 .. LängsterText loop

               if To_Wide_Wide_String (Source => TextForschung (A).Text) = "|" then
                  exit AnzeigeSchleife;
                  
               elsif B = 1 then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif B = LängsterText then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => TextForschung (A).Text));

                  for Leer in 1 .. LängsterText - To_Wide_Wide_String (Source => TextForschung (A).Text)'Length loop
                        
                     Put (" ");
                        
                  end loop;
                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop;

            for C in 1 .. LängsterText loop
               
               if C = LängsterText then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop;
         
         else
            if To_Wide_Wide_String (Source => TextForschung (A).Text) = "|" then
               exit AnzeigeSchleife; 
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => TextForschung (A).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeForschung;



   procedure AnzeigeLangerText (WelcherText, WelcheZeile : in Positive) is
   begin
      
      Text := (others => ('|'));
      N := 1;
      New_Line;

      for A in To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (WelcherText, WelcheZeile))'Range loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (WelcherText, WelcheZeile)) (A) = '|' then
            exit;
            
         else
            Text (A) := To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (WelcherText, WelcheZeile)) (A);
         end if;
         
      end loop;
      
      for B in Text'Range loop
         
         if Text (B) = '|' then
            exit;
            
         elsif B - 80 * N > 1 then
            if Text (B) = ' ' then
               N := N + 1;
               New_Line;
               
            else
               Put (Item => Text (B));
            end if;
            
         else
            Put (Item => Text (B));
         end if;
         
      end loop;
      New_Line;
      
   end AnzeigeLangerText;




end Anzeige;

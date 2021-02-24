pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

package body Anzeige is

   procedure AnzeigeOhneAuswahlNeu (ÜberschriftDatei, TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; ÜberschriftZeile, ErsteZeile, LetzteZeile : in Natural;
                                    AbstandAnfang, AbstandMitte, AbstandEnde : in GlobaleDatentypen.WelcherAbstand_Enum) is
   begin
        
      case ÜberschriftDatei is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (ÜberschriftDatei), ÜberschriftZeile)));
      end case;

      case AbstandAnfang is
         when GlobaleDatentypen.Keiner =>
            null;

         when GlobaleDatentypen.Kleiner_Abstand =>
            Put (Item => " ");
            
         when GlobaleDatentypen.Großer_Abstand =>
            Put (Item => "    ");
            
         when GlobaleDatentypen.Neue_Zeile =>
            New_Line;
      end case;

      TextAnzeigeSchleife:
      for TextZeile in ErsteZeile .. LetzteZeile loop
         
         Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), TextZeile)));
                  
         if ErsteZeile = LetzteZeile or AbstandMitte = GlobaleDatentypen.Keiner then
            null;
            
         elsif TextZeile < LetzteZeile and TextZeile > ErsteZeile and (TextZeile - ErsteZeile) mod 2 = 0 then
            case AbstandMitte is
               when GlobaleDatentypen.Keiner =>
                  null;
                  
               when GlobaleDatentypen.Kleiner_Abstand =>
                  Put (Item => " ");
            
               when GlobaleDatentypen.Großer_Abstand =>
                  Put (Item => "    ");
            
               when GlobaleDatentypen.Neue_Zeile =>
                  New_Line;
            end case;

         else
            null;
         end if;

      end loop TextAnzeigeSchleife;
      
      case AbstandEnde is
         when GlobaleDatentypen.Keiner =>
            null;

         when GlobaleDatentypen.Kleiner_Abstand =>
            Put (Item => " ");
            
         when GlobaleDatentypen.Großer_Abstand =>
            Put (Item => "    ");
            
         when GlobaleDatentypen.Neue_Zeile =>
            New_Line;
      end case;
      
   end AnzeigeOhneAuswahlNeu;



   procedure EinzeiligeAnzeigeOhneAuswahl (TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; TextZeile : in Positive) is
   begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                     TextDatei        => TextDatei,
                                     ÜberschriftZeile => 0,
                                     ErsteZeile       => TextZeile,
                                     LetzteZeile      => TextZeile,
                                     AbstandAnfang    => GlobaleDatentypen.Keiner,
                                     AbstandMitte     => GlobaleDatentypen.Keiner,
                                     AbstandEnde      => GlobaleDatentypen.Neue_Zeile);

      case TextDatei is
         when GlobaleDatentypen.Fehlermeldungen =>
            delay 1.0;
            
         when others =>
            null;
      end case;
      
   end EinzeiligeAnzeigeOhneAuswahl;



   procedure AnzeigeMitAuswahlNeu (FrageDatei, TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; FrageZeile, ErsteZeile, LetzteZeile, AktuelleAuswahl : in Natural) is
   begin
        
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for Zeilen in ErsteZeile .. LetzteZeile loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), Zeilen))'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), Zeilen))'Length;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;

      case FrageDatei is
         when GlobaleDatentypen.Leer =>
            null;

         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (FrageDatei), FrageZeile)));
      end case;
      
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
                  Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), Zeile)));

                  for Leer in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), Zeile))'Length loop
                        
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
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDatei), Zeile)));
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeMitAuswahlNeu;



   procedure AnzeigeStadt (AktuelleAuswahl : in Positive) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for A in GlobaleVariablen.TexteEinlesenNeuArray'Range (2) loop
         if To_Wide_Wide_String (Source => TextBauen (A).Text) = "|" then
            exit TextlängePrüfenSchleife;
            
         elsif To_Wide_Wide_String (Source => TextBauen (A).Text)'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => TextBauen (A).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for A in GlobaleVariablen.TexteEinlesenNeuArray'Range (2) loop

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
      for A in GlobaleVariablen.TexteEinlesenNeuArray'Range (2) loop
         if To_Wide_Wide_String (Source => TextForschung (A).Text) = "|" then
            exit TextlängePrüfenSchleife;
            
         elsif To_Wide_Wide_String (Source => TextForschung (A).Text)'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => TextForschung (A).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for A in GlobaleVariablen.TexteEinlesenNeuArray'Range (2) loop

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

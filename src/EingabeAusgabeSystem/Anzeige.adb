pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleVariablen;

package body Anzeige is

   procedure AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern, TextDateiExtern : in GlobaleDatentypen.WelcheDatei_Enum; ÜberschriftZeileExtern : in Natural; ErsteZeileExtern, LetzteZeileExtern : in Positive;
                                    AbstandAnfangExtern, AbstandMitteExtern, AbstandEndeExtern : in GlobaleDatentypen.WelcherAbstand_Enum) is
   begin
        
      case ÜberschriftDateiExtern is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (ÜberschriftDateiExtern), ÜberschriftZeileExtern)));
      end case;

      case AbstandAnfangExtern is
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
      for TextZeile in ErsteZeileExtern .. LetzteZeileExtern loop
         
         Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), TextZeile)));
                  
         if ErsteZeileExtern = LetzteZeileExtern or AbstandMitteExtern = GlobaleDatentypen.Keiner then
            null;
            
         elsif ErsteZeileExtern < LetzteZeileExtern then
            case AbstandMitteExtern is
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
      
      case AbstandEndeExtern is
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



   procedure EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern : in GlobaleDatentypen.WelcheDatei_Enum; TextZeileExtern : in Positive) is
   begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => TextDateiExtern,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => TextZeileExtern,
                                     LetzteZeileExtern      => TextZeileExtern,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Neue_Zeile);

      case TextDateiExtern is
         when GlobaleDatentypen.Fehlermeldungen =>
            delay 1.0;
            
         when others =>
            null;
      end case;
      
   end EinzeiligeAnzeigeOhneAuswahl;



   procedure AnzeigeMitAuswahlNeu (FrageDateiExtern, TextDateiExtern : in GlobaleDatentypen.WelcheDatei_Enum; FrageZeileExtern, ErsteZeileExtern, LetzteZeileExtern, AktuelleAuswahlExtern : in Natural) is
   begin
        
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for Zeilen in ErsteZeileExtern .. LetzteZeileExtern loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), Zeilen))'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), Zeilen))'Length;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;

      case FrageDateiExtern is
         when GlobaleDatentypen.Leer =>
            null;

         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (FrageDateiExtern), FrageZeileExtern)));
      end case;
      
      AnzeigeSchleife:
      for Zeile in ErsteZeileExtern .. LetzteZeileExtern loop

         if AktuelleAuswahlExtern = Zeile then
            RahmenTeilEinsSchleife:
            for TextlängeEins in 1 .. LängsterText loop
                  
               if TextlängeEins = 1 then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif TextlängeEins = LängsterText then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), Zeile)));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), Zeile))'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;

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
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), Zeile)));
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeMitAuswahlNeu;



   procedure AnzeigeSprache (AktuelleAuswahlExtern, ErsteZeileExtern, LetzteZeileExtern : in Positive) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for Zeilen in ErsteZeileExtern .. LetzteZeileExtern loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.SprachenEinlesen (Zeilen))'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => GlobaleVariablen.SprachenEinlesen (Zeilen))'Length;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for Zeile in ErsteZeileExtern .. LetzteZeileExtern loop

         if AktuelleAuswahlExtern = Zeile then
            RahmenTeilEinsSchleife:
            for TextlängeEins in 1 .. LängsterText loop
                  
               if TextlängeEins = 1 then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif TextlängeEins = LängsterText then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.SprachenEinlesen (Zeile)));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleVariablen.SprachenEinlesen (Zeile))'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;

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
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.SprachenEinlesen (Zeile)));
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeSprache;



   procedure AnzeigeStadt (AktuelleAuswahlExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for Zeichen in TextBauenNeuArray'Range loop
         if To_Wide_Wide_String (Source => TextBauenNeu (Zeichen).Text) = "|" then
            exit TextlängePrüfenSchleife;
            
         elsif To_Wide_Wide_String (Source => TextBauenNeu (Zeichen).Text)'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => TextBauenNeu (Zeichen).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for A in TextBauenNeuArray'Range loop

         if AktuelleAuswahlExtern = A then
            for B in 1 .. LängsterText loop
                  
               if B = 1 then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif B = LängsterText then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => TextBauenNeu (A).Text));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => TextBauenNeu (A).Text)'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;
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
            if To_Wide_Wide_String (Source => TextBauenNeu (A).Text) = "|" then
               exit AnzeigeSchleife; 
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => TextBauenNeu (A).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeStadt;
   
   
   
   procedure AnzeigeForschungNeu (AktuelleAuswahlExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for Zeichen in TextForschungNeuArray'Range loop
         if To_Wide_Wide_String (Source => TextForschungNeu (Zeichen).Text) = "|" then
            exit TextlängePrüfenSchleife;
            
         elsif To_Wide_Wide_String (Source => TextForschungNeu (Zeichen).Text)'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Source => TextForschungNeu (Zeichen).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for A in TextForschungNeuArray'Range loop

         if AktuelleAuswahlExtern = A then
            for B in 1 .. LängsterText loop
                  
               if B = 1 then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif B = LängsterText then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => TextForschungNeu (A).Text));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => TextForschungNeu (A).Text)'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;
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
            if To_Wide_Wide_String (Source => TextForschungNeu (A).Text) = "|" then
               exit AnzeigeSchleife; 
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => TextForschungNeu (A).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeForschungNeu;



   procedure AnzeigeLangerTextNeu (ÜberschriftDateiExtern, TextDateiExtern : in GlobaleDatentypen.WelcheDatei_Enum; ÜberschriftZeileExtern : in Natural; ErsteZeileExtern, LetzteZeileExtern : in Positive;
                                   AbstandAnfangExtern, AbstandEndeExtern : in GlobaleDatentypen.WelcherAbstand_Enum) is
   begin
      
      case ÜberschriftDateiExtern is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (ÜberschriftDateiExtern), ÜberschriftZeileExtern)));
      end case;

      case AbstandAnfangExtern is
         when GlobaleDatentypen.Keiner =>
            null;

         when GlobaleDatentypen.Kleiner_Abstand =>
            Put (Item => " ");
            
         when GlobaleDatentypen.Großer_Abstand =>
            Put (Item => "    ");
            
         when GlobaleDatentypen.Neue_Zeile =>
            New_Line;
      end case;

      N := 1;

      TextNeu := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), ErsteZeileExtern);
      
      AnzeigeSchleife:
      for Zeichen in To_Wide_Wide_String (Source => TextNeu)'Range loop
         
         if To_Wide_Wide_String (Source => TextNeu) (Zeichen) = '|' then
            exit AnzeigeSchleife;
            
         elsif Zeichen - Zeichengrenze * N > 1 then
            if To_Wide_Wide_String (Source => TextNeu) (Zeichen) = ' ' then
               N := N + 1;
               New_Line;
               
            else
               Put (Item => To_Wide_Wide_String (Source => TextNeu) (Zeichen));
            end if;
            
         else
            Put (Item => To_Wide_Wide_String (Source => TextNeu) (Zeichen));
         end if;
         
      end loop AnzeigeSchleife;

      case AbstandEndeExtern is
         when GlobaleDatentypen.Keiner =>
            null;

         when GlobaleDatentypen.Kleiner_Abstand =>
            Put (Item => " ");
            
         when GlobaleDatentypen.Großer_Abstand =>
            Put (Item => "    ");
            
         when GlobaleDatentypen.Neue_Zeile =>
            New_Line;
      end case;
      
   end AnzeigeLangerTextNeu;

end Anzeige;

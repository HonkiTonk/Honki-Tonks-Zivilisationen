pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleVariablen;

package body Anzeige is

   procedure AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern, TextDateiExtern : in GlobaleDatentypen.WelcheDatei_Enum; ÜberschriftZeileExtern : in Natural; ErsteZeileExtern, LetzteZeileExtern : in Positive;
                                    AbstandAnfangExtern, AbstandMitteExtern, AbstandEndeExtern : in GlobaleDatentypen.WelcherAbstand_Enum) is
   begin
        
      case
        ÜberschriftDateiExtern
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (ÜberschriftDateiExtern), ÜberschriftZeileExtern)));
      end case;

      case
        AbstandAnfangExtern
      is
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
      for TextZeileSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), TextZeileSchleifenwert)));
                  
         if
           ErsteZeileExtern = LetzteZeileExtern
           or
             AbstandMitteExtern = GlobaleDatentypen.Keiner
         then
            null;
            
         elsif
           ErsteZeileExtern < LetzteZeileExtern
         then
            case
              AbstandMitteExtern
            is
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
      
      case
        AbstandEndeExtern
      is
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

      case
        TextDateiExtern
      is
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
      for ZeilenSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         if
           To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), ZeilenSchleifenwert))'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), ZeilenSchleifenwert))'Length;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;

      case
        FrageDateiExtern
      is
         when GlobaleDatentypen.Leer =>
            null;

         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (FrageDateiExtern), FrageZeileExtern)));
      end case;
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop

         if AktuelleAuswahlExtern = ZeileSchleifenwert then
            RahmenTeilEinsSchleife:
            for TextlängeEins in 1 .. LängsterText loop
                  
               if
                 TextlängeEins = 1
               then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif
                 TextlängeEins = LängsterText
               then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert)));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert))'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;

                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop RahmenTeilEinsSchleife;

            RahmenTeilZweiSchleife:
            for TextlängeZweiSchleifenwert in 1 .. LängsterText loop
               
               if
                 TextlängeZweiSchleifenwert = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop RahmenTeilZweiSchleife;
         
         else
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert)));
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeMitAuswahlNeu;



   procedure AnzeigeSprache (AktuelleAuswahlExtern, ErsteZeileExtern, LetzteZeileExtern : in Positive) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeilenSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         if
           To_Wide_Wide_String (Source => GlobaleVariablen.SprachenEinlesen (ZeilenSchleifenwert))'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => GlobaleVariablen.SprachenEinlesen (ZeilenSchleifenwert))'Length;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop

         if
           AktuelleAuswahlExtern = ZeileSchleifenwert
         then
            RahmenTeilEinsSchleife:
            for TextlängeEins in 1 .. LängsterText loop
                  
               if
                 TextlängeEins = 1
               then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif
                 TextlängeEins = LängsterText
               then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.SprachenEinlesen (ZeileSchleifenwert)));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleVariablen.SprachenEinlesen (ZeileSchleifenwert))'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;

                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop RahmenTeilEinsSchleife;

            RahmenTeilZweiSchleife:
            for TextlängeZweiSchleifenwert in 1 .. LängsterText loop
               
               if
                 TextlängeZweiSchleifenwert = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop RahmenTeilZweiSchleife;
         
         else
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.SprachenEinlesen (ZeileSchleifenwert)));
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeSprache;



   procedure AnzeigeStadt (AktuelleAuswahlExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeichenSchleifenwert in TextBauenNeuArray'Range loop
         if
           To_Wide_Wide_String (Source => TextBauenNeu (ZeichenSchleifenwert).Text) = "|"
         then
            exit TextlängePrüfenSchleife;
            
         elsif
           To_Wide_Wide_String (Source => TextBauenNeu (ZeichenSchleifenwert).Text)'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => TextBauenNeu (ZeichenSchleifenwert).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for AnzeigeSchleifenwert in TextBauenNeuArray'Range loop

         if
           AktuelleAuswahlExtern = AnzeigeSchleifenwert
         then
            RahmenEinsSchleife:
            for RahmenEinsSchleifenwert in 1 .. LängsterText loop
                  
               if
                 RahmenEinsSchleifenwert = 1
               then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif
                 RahmenEinsSchleifenwert = LängsterText
               then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => TextBauenNeu (AnzeigeSchleifenwert).Text));

                  LeererPlatzSchleife:
                  for LeererPlatzSchleifenwert in 1 .. LängsterText - To_Wide_Wide_String (Source => TextBauenNeu (AnzeigeSchleifenwert).Text)'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;
                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop RahmenEinsSchleife;

            RahmenZweiSchleife:
            for RahmenZweiSchleifenwert in 1 .. LängsterText loop
               
               if
                 RahmenZweiSchleifenwert = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop RahmenZweiSchleife;
         
         else
            if
              To_Wide_Wide_String (Source => TextBauenNeu (AnzeigeSchleifenwert).Text) = "|"
            then
               exit AnzeigeSchleife; 
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => TextBauenNeu (AnzeigeSchleifenwert).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeStadt;
   
   
   
   procedure AnzeigeForschungNeu (AktuelleAuswahlExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeichenSchleifenwert in TextForschungNeuArray'Range loop
         if
           To_Wide_Wide_String (Source => TextForschungNeu (ZeichenSchleifenwert).Text) = "|"
         then
            exit TextlängePrüfenSchleife;
            
         elsif
           To_Wide_Wide_String (Source => TextForschungNeu (ZeichenSchleifenwert).Text)'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => TextForschungNeu (ZeichenSchleifenwert).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for AnzeigeSchleifenwert in TextForschungNeuArray'Range loop

         if
           AktuelleAuswahlExtern = AnzeigeSchleifenwert
         then
            RahmenEinsSchleife:
            for RahmenEinsSchleifenwert in 1 .. LängsterText loop
                  
               if
                 RahmenEinsSchleifenwert = 1
               then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif
                 RahmenEinsSchleifenwert = LängsterText
               then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => TextForschungNeu (AnzeigeSchleifenwert).Text));

                  LeererPlatzSchleife:
                  for LeererPlatzSchleifenwert in 1 .. LängsterText - To_Wide_Wide_String (Source => TextForschungNeu (AnzeigeSchleifenwert).Text)'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;
                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop RahmenEinsSchleife;

            RahmenZweiSchleife:
            for RahmenZweiSchleifenwert in 1 .. LängsterText loop
               
               if
                 RahmenZweiSchleifenwert = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop RahmenZweiSchleife;
         
         else
            if
              To_Wide_Wide_String (Source => TextForschungNeu (AnzeigeSchleifenwert).Text) = "|"
            then
               exit AnzeigeSchleife; 
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => TextForschungNeu (AnzeigeSchleifenwert).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeForschungNeu;



   procedure AnzeigeTransporter (AktuelleAuswahlExtern : in Natural) is
   begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeichenSchleifenwert in TextTransporter'Range loop
         if
           To_Wide_Wide_String (Source => TextTransporter (ZeichenSchleifenwert).Text) = "|"
         then
            exit TextlängePrüfenSchleife;
            
         elsif
           To_Wide_Wide_String (Source => TextTransporter (ZeichenSchleifenwert).Text)'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => TextTransporter (ZeichenSchleifenwert).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for AnzeigeSchleifenwert in TextTransporter'Range loop

         if
           AktuelleAuswahlExtern = AnzeigeSchleifenwert
         then
            RahmenEinsSchleife:
            for RahmenEinsSchleifenwert in 1 .. LängsterText loop
                  
               if
                 RahmenEinsSchleifenwert = 1
               then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif
                 RahmenEinsSchleifenwert = LängsterText
               then                  
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => TextTransporter (AnzeigeSchleifenwert).Text));

                  LeererPlatzSchleife:
                  for LeererPlatzSchleifenwert in 1 .. LängsterText - To_Wide_Wide_String (Source => TextTransporter (AnzeigeSchleifenwert).Text)'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;
                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop RahmenEinsSchleife;

            RahmenZweiSchleife:
            for RahmenZweiSchleifenwert in 1 .. LängsterText loop
               
               if
                 RahmenZweiSchleifenwert = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop RahmenZweiSchleife;
         
         else
            if
              To_Wide_Wide_String (Source => TextTransporter (AnzeigeSchleifenwert).Text) = "|"
            then
               exit AnzeigeSchleife; 
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => TextTransporter (AnzeigeSchleifenwert).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeTransporter;

   

   procedure AnzeigeLangerTextNeu (ÜberschriftDateiExtern, TextDateiExtern : in GlobaleDatentypen.WelcheDatei_Enum; ÜberschriftZeileExtern : in Natural; ErsteZeileExtern, LetzteZeileExtern : in Positive;
                                   AbstandAnfangExtern, AbstandEndeExtern : in GlobaleDatentypen.WelcherAbstand_Enum) is
   begin
      
      case
        ÜberschriftDateiExtern
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (ÜberschriftDateiExtern), ÜberschriftZeileExtern)));
      end case;

      case
        AbstandAnfangExtern
      is
         when GlobaleDatentypen.Keiner =>
            null;

         when GlobaleDatentypen.Kleiner_Abstand =>
            Put (Item => " ");
            
         when GlobaleDatentypen.Großer_Abstand =>
            Put (Item => "    ");
            
         when GlobaleDatentypen.Neue_Zeile =>
            New_Line;
      end case;

      ZeichengrenzenMultiplikator := 1;

      TextNeu := GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.WelcheDatei_Enum'Pos (TextDateiExtern), ErsteZeileExtern);
      
      AnzeigeSchleife:
      for ZeichenSchleifenwert in To_Wide_Wide_String (Source => TextNeu)'Range loop
         
         if
           To_Wide_Wide_String (Source => TextNeu) (ZeichenSchleifenwert) = '|'
         then
            exit AnzeigeSchleife;
            
         elsif
           ZeichenSchleifenwert - Zeichengrenze * ZeichengrenzenMultiplikator > 1
         then
            if
              To_Wide_Wide_String (Source => TextNeu) (ZeichenSchleifenwert) = ' '
            then
               ZeichengrenzenMultiplikator := ZeichengrenzenMultiplikator + 1;
               New_Line;
               
            else
               Put (Item => To_Wide_Wide_String (Source => TextNeu) (ZeichenSchleifenwert));
            end if;
            
         else
            Put (Item => To_Wide_Wide_String (Source => TextNeu) (ZeichenSchleifenwert));
         end if;
         
      end loop AnzeigeSchleife;

      case
        AbstandEndeExtern
      is
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

pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with SystemKonstanten;

with GrafikAllgemein;
with Eingabe;
with GrafikEinstellungen;

package body Anzeige is

   procedure AnzeigeOhneAuswahlNeu
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandMitteExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
   is begin
        
      case
        ÜberschriftDateiExtern
      is
         when GlobaleTexte.Leer =>
            null;
            
         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (ÜberschriftDateiExtern), ÜberschriftZeileExtern)));
      end case;

      AbstandEinbauen (AbstandExtern => AbstandAnfangExtern);

      TextAnzeigeSchleife:
      for TextZeileSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         Put (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), TextZeileSchleifenwert)));
                  
         if
           ErsteZeileExtern = LetzteZeileExtern
           or
             AbstandMitteExtern = GlobaleTexte.Leer
         then
            null;
            
         elsif
           ErsteZeileExtern < LetzteZeileExtern
         then
            AbstandEinbauen (AbstandExtern => AbstandMitteExtern);

         else
            null;
         end if;

      end loop TextAnzeigeSchleife;
      
      AbstandEinbauen (AbstandExtern => AbstandEndeExtern);
      
   end AnzeigeOhneAuswahlNeu;



   procedure EinzeiligeAnzeigeOhneAuswahl
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextZeileExtern : in Positive)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => TextDateiExtern,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => TextZeileExtern,
                                     LetzteZeileExtern      => TextZeileExtern,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);

      if
        TextDateiExtern = GlobaleTexte.Fehlermeldungen
        and
          TextZeileExtern /= 16
      then
         Eingabe.WartenEingabe;
            
      else
         null;
      end if;
      
   end EinzeiligeAnzeigeOhneAuswahl;



   procedure AnzeigeMitAuswahlNeu
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive)
   is begin
        
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeilenSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeilenSchleifenwert))'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeilenSchleifenwert))'Length;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;

      GrafischeAnzeigeAuswahl (FrageDateiExtern            => FrageDateiExtern,
                               TextDateiExtern             => TextDateiExtern,
                               FrageZeileExtern            => FrageZeileExtern,
                               ErsteZeileExtern            => ErsteZeileExtern,
                               LetzteZeileExtern           => LetzteZeileExtern,
                               AktuelleAuswahlExtern       => AktuelleAuswahlExtern,
                               MaximaleAnzahlZeichenExtern => LängsterText);
      
      case
        FrageDateiExtern
      is
         when GlobaleTexte.Leer =>
            null;

         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (FrageDateiExtern), FrageZeileExtern)));
      end case;
      
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
                  Put (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert)));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert))'Length loop
                     
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
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert)));
         end if;
         
      end loop AnzeigeSchleife;
      
      GrafikAllgemein.FensterAnzeigen;
      
   end AnzeigeMitAuswahlNeu;
   
   
   
   procedure GrafischeAnzeigeAuswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive;
      MaximaleAnzahlZeichenExtern : in Natural)
   is begin
      
      GrafikAllgemein.FensterLeeren;
      
      case
        FrageDateiExtern
      is
         when GlobaleTexte.Leer =>
            ÜberschriftAbstand := 0;

         when others =>
            ÜberschriftAbstand := 1;
            Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.Text,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (FrageDateiExtern), FrageZeileExtern)));
            Sf.Graphics.Text.setPosition (text     => GrafikEinstellungen.Text,
                                          position => StartAnzeigePosition);
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                               text         => GrafikEinstellungen.Text);
      end case;
            
      RahmenGezeichnet := False;
      AktuellePosition.x := StartAnzeigePosition.x;
      AktuelleZeile := 0;
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
                  
         if
           AktuelleAuswahlExtern - ZeileSchleifenwert < -5
         then
            exit AnzeigeSchleife;
            
         elsif
           AktuelleAuswahlExtern - ZeileSchleifenwert > 5
         then
            null;
            
         else
            AnzeigeSelbst (TextDateiExtern             => TextDateiExtern,
                           AktuelleAuswahlExtern       => AktuelleAuswahlExtern,
                           MaximaleAnzahlZeichenExtern => MaximaleAnzahlZeichenExtern,
                           AktuelleZeileExtern         => ZeileSchleifenwert);
            
            AktuelleZeile := AktuelleZeile + 1;
         end if;
         
      end loop AnzeigeSchleife;
      
      GrafikAllgemein.FensterAnzeigen;
      
   end GrafischeAnzeigeAuswahl;
   
   
   
   procedure AnzeigeSelbst
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      AktuelleAuswahlExtern : in Positive;
      MaximaleAnzahlZeichenExtern : in Natural;
      AktuelleZeileExtern : in Natural)
   is begin
      
      if
        AktuelleAuswahlExtern = AktuelleZeileExtern
      then
         RahmenGezeichnet := True;
         Rahmenlänge := Float (MaximaleAnzahlZeichenExtern * Positive (GrafikEinstellungen.Schriftgröße)) * 0.50;
         Rahmenbreite := Float (GrafikEinstellungen.Schriftgröße) * 1.35;
            
         case
           RahmenGezeichnet
         is
            when True =>
               AktuellePosition.y := StartAnzeigePosition.y + (Float (GrafikEinstellungen.Schriftgröße) + Zeilenabstand) * (Float (ÜberschriftAbstand + AktuelleZeile));
                  
            when False =>
               -- Sollte niemals eintreten.
               raise Program_Error;
         end case;
            
         Sf.Graphics.RectangleShape.setSize (shape => Rechteck,
                                             size  => (Rahmenlänge, Rahmendicke));
         Sf.Graphics.RectangleShape.setPosition (shape    => Rechteck,
                                                 position => AktuellePosition);
         Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                      object       => Rechteck);
            
         Sf.Graphics.RectangleShape.setSize (shape => Rechteck,
                                             size  => (Rahmendicke, Rahmenbreite));
         Sf.Graphics.RectangleShape.setPosition (shape    => Rechteck,
                                                 position => AktuellePosition);
         Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                      object       => Rechteck);
            
         Sf.Graphics.RectangleShape.setSize (shape => Rechteck,
                                             size  => (Rahmendicke, Rahmenbreite));
         Sf.Graphics.RectangleShape.setPosition (shape    => Rechteck,
                                                 position => (AktuellePosition.x + Rahmenlänge, AktuellePosition.y));
         Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                      object       => Rechteck);
            
         AktuellePosition.x := StartAnzeigePosition.x + Rahmendicke + Rahmenabstand;
            
         Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.Text,
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleZeileExtern)));
         Sf.Graphics.Text.setPosition (text     => GrafikEinstellungen.Text,
                                       position => AktuellePosition);
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                            text         => GrafikEinstellungen.Text);
                        
         AktuellePosition.x := StartAnzeigePosition.x;
            
         Sf.Graphics.RectangleShape.setSize (shape => Rechteck,
                                             -- Aus irgendeinem Grund bleibt die rechte untere Eckte frei ohne den Extrawert, warum?
                                             size  => (Rahmenlänge + 3.00, Rahmendicke));
         Sf.Graphics.RectangleShape.setPosition (shape    => Rechteck,
                                                 position => (AktuellePosition.x, AktuellePosition.y + Rahmenbreite));
         Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                      object       => Rechteck);
         
      else
         case
           RahmenGezeichnet
         is
            when True =>
               AktuellePosition.y := StartAnzeigePosition.y + (Float (GrafikEinstellungen.Schriftgröße) + Zeilenabstand) * (Float (ÜberschriftAbstand + AktuelleZeile));
               AktuellePosition.y := AktuellePosition.y + 2.00 * Rahmendicke;
                  
            when False =>
               AktuellePosition.y := StartAnzeigePosition.y + (Float (GrafikEinstellungen.Schriftgröße) + Zeilenabstand) * (Float (ÜberschriftAbstand + AktuelleZeile));
         end case;
            
         Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.Text,
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleZeileExtern)));
         Sf.Graphics.Text.setPosition (text     => GrafikEinstellungen.Text,
                                       position => AktuellePosition);
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                            text         => GrafikEinstellungen.Text);
      end if;
      
   end AnzeigeSelbst;
   
   
   
   procedure AllgemeineAnzeige
     (AktuelleAuswahlExtern : in EinheitStadtDatentypen.MinimimMaximumID)
   is begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeichenSchleifenwert in AlgemeineAnzeigeTextArray'Range loop
         if
           To_Wide_Wide_String (Source => AllgemeineAnzeigeText (ZeichenSchleifenwert).Text) = SystemKonstanten.LeerText
         then
            exit TextlängePrüfenSchleife;
            
         elsif
           To_Wide_Wide_String (Source => AllgemeineAnzeigeText (ZeichenSchleifenwert).Text)'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => AllgemeineAnzeigeText (ZeichenSchleifenwert).Text)'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for AnzeigeSchleifenwert in AlgemeineAnzeigeTextArray'Range loop

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
                  Put (Item => To_Wide_Wide_String (Source => AllgemeineAnzeigeText (AnzeigeSchleifenwert).Text));

                  LeererPlatzSchleife:
                  for LeererPlatzSchleifenwert in 1 .. LängsterText - To_Wide_Wide_String (Source => AllgemeineAnzeigeText (AnzeigeSchleifenwert).Text)'Length loop
                        
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
              To_Wide_Wide_String (Source => AllgemeineAnzeigeText (AnzeigeSchleifenwert).Text) = SystemKonstanten.LeerText
            then
               exit AnzeigeSchleife;
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => AllgemeineAnzeigeText (AnzeigeSchleifenwert).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AllgemeineAnzeige;

   

   procedure AnzeigeSprache
     (AktuelleAuswahlExtern : in Positive;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive)
   is begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeilenSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.SprachenEinlesen (ZeilenSchleifenwert))'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => GlobaleTexte.SprachenEinlesen (ZeilenSchleifenwert))'Length;
            
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
                  Put (Item => To_Wide_Wide_String (Source => GlobaleTexte.SprachenEinlesen (ZeileSchleifenwert)));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleTexte.SprachenEinlesen (ZeileSchleifenwert))'Length loop
                        
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
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.SprachenEinlesen (ZeileSchleifenwert)));
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeSprache;

   

   procedure AnzeigeLangerTextNeu
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
   is begin
      
      case
        ÜberschriftDateiExtern
      is
         when GlobaleTexte.Leer =>
            null;
            
         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (ÜberschriftDateiExtern), ÜberschriftZeileExtern)));
      end case;
      
      AbstandEinbauen (AbstandExtern => AbstandAnfangExtern);

      ZeichengrenzenMultiplikator := 1;

      TextNeu := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ErsteZeileExtern);
      
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

      AbstandEinbauen (AbstandExtern => AbstandEndeExtern);
      
   end AnzeigeLangerTextNeu;
   
   
   
   procedure AbstandEinbauen
     (AbstandExtern : in GlobaleTexte.Welcher_Abstand_Enum)
   is begin
      
      case
        AbstandExtern
      is
         when GlobaleTexte.Leer =>
            null;

         when GlobaleTexte.Kleiner_Abstand =>
            Put (Item => " ");
            
         when GlobaleTexte.Großer_Abstand =>
            Put (Item => "    ");
            
         when GlobaleTexte.Neue_Zeile =>
            New_Line;
      end case;
      
   end AbstandEinbauen;

end Anzeige;

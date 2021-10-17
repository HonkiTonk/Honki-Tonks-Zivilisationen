pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Color;
with Sf.Graphics.RenderWindow;

with GrafikAllgemein;
with GrafikEinstellungen;

package body TextAnzeigeSFML is

   procedure AnzeigeMitAuswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive)
   is begin
      
      TextZugriff := GrafikEinstellungen.TextStandard;
      GrafikAllgemein.FensterLeeren;
      
      LängsterText := ErsteZeileExtern;
      
      TextlängePrüfenSchleife:
      for ZeilenSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeilenSchleifenwert))'Length
           > To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), LängsterText))'Length
         then
            LängsterText := ZeilenSchleifenwert;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;
      
      case
        FrageDateiExtern
      is
         when GlobaleTexte.Leer =>
            ÜberschriftAbstand := 0;

         when others =>
            ÜberschriftAbstand := 1;
            TextSetzen (TextExtern        => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (FrageDateiExtern), FrageZeileExtern)),
                        TextZugriffExtern => TextZugriff);
            TextZeichnen (PositionExtern    => (TextMittelPositionErmitteln (TextZugriffExtern => TextZugriff), StartAnzeigePosition.y),
                          TextZugriffExtern => TextZugriff);
      end case;
      
      RahmenGezeichnet := False;
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
            AnzeigeSelbst (TextDateiExtern        => TextDateiExtern,
                           AktuelleAuswahlExtern  => AktuelleAuswahlExtern,
                           AktuelleZeileExtern    => ZeileSchleifenwert);
            
            AktuelleZeile := AktuelleZeile + 1;
         end if;
         
      end loop AnzeigeSchleife;
      
      GrafikAllgemein.FensterAnzeigen;
      
   end AnzeigeMitAuswahl;
   
   
   
   procedure TextSetzen
     (TextExtern : in Wide_Wide_String;
      TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextZugriffExtern,
                                         str  => TextExtern);
      
   end TextSetzen;
   
   
   
   procedure TextZeichnen
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
   is begin
            
      Sf.Graphics.Text.setPosition (text     => TextZugriffExtern,
                                    position => PositionExtern);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextZugriffExtern);
      
   end TextZeichnen;
   
   
   
   function TextBreiteErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
     return Float
   is begin
      
      return Sf.Graphics.Text.getLocalBounds (text => TextZugriffExtern).width;
      
   end TextBreiteErmitteln;
   
   
   
   function TextMittelPositionErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      return (Float (GrafikEinstellungen.FensterBreite) / 2.00 - TextBreiteErmitteln (TextZugriffExtern => TextZugriffExtern) / 2.00);
      
   end TextMittelPositionErmitteln;
   
   
   
   procedure AnzeigeSelbst
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      AktuelleAuswahlExtern : in Positive;
      AktuelleZeileExtern : in Natural)
   is begin
      
      TextSetzen (TextExtern        => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleZeileExtern)),
                  TextZugriffExtern => TextZugriff);
      AktuellePosition.y := StartAnzeigePosition.y + YPositionBestimmen;
      AktuellePosition.x := TextMittelPositionErmitteln (TextZugriffExtern => TextZugriff);
      
      if
        AktuelleAuswahlExtern = AktuelleZeileExtern
      then
         RahmenGezeichnet := True;
         Rahmenhöhe := RahmenhöheErmitteln (TextDateiExtern => TextDateiExtern);
         Rahmenlänge := RahmenlängeErmitteln (TextDateiExtern => TextDateiExtern);
            
         GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Rahmenlänge, Rahmendicke),
                                           PositionExtern  => AktuellePosition,
                                           FarbeExtern     => (Sf.Graphics.Color.sfWhite));
            
         GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Rahmenlänge, Rahmendicke),
                                           PositionExtern  => (AktuellePosition.x, AktuellePosition.y + Rahmenhöhe),
                                           FarbeExtern     => (Sf.Graphics.Color.sfWhite));
            
         GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Rahmendicke, Rahmenhöhe),
                                           PositionExtern  => AktuellePosition,
                                           FarbeExtern     => (Sf.Graphics.Color.sfWhite));
            
         if
           AktuellePosition.x + Rahmenlänge - Rahmendicke > Float (GrafikEinstellungen.FensterBreite)
         then
            Position := Float (GrafikEinstellungen.FensterBreite);
            
         else
            Position := AktuellePosition.x + Rahmenlänge - Rahmendicke;
         end if;
         
         GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Rahmendicke, Rahmenhöhe),
                                           PositionExtern  => (Position, AktuellePosition.y),
                                           FarbeExtern     => (Sf.Graphics.Color.sfWhite));
            
         AktuellePosition.x := TextMittelPositionErmitteln (TextZugriffExtern => TextZugriff);
         
         GrafikAllgemein.TextDateiZeichnen (PositionExtern    => AktuellePosition,
                                            TextDateiExtern   => TextDateiExtern,
                                            WelcheZeileExtern => AktuelleZeileExtern);
         
      else
         case
           RahmenGezeichnet
         is
            when True =>
               AktuellePosition.y := AktuellePosition.y + 2.00 * Rahmendicke;
                  
            when False =>
               null;
         end case;
         
         GrafikAllgemein.TextDateiZeichnen (PositionExtern    => AktuellePosition,
                                            TextDateiExtern   => TextDateiExtern,
                                            WelcheZeileExtern => AktuelleZeileExtern);
      end if;
      
   end AnzeigeSelbst;
   
   
   
   function YPositionBestimmen
     return Float
   is begin
      
      return (Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => GrafikEinstellungen.TextStandard).height) * (Float (AktuelleZeile + ÜberschriftAbstand));
      
   end YPositionBestimmen;
   
   
   
   function RahmenhöheErmitteln
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum)
      return Float
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.TextStandard,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), LängsterText)));
      
      return Sf.Graphics.Text.getLocalBounds (text => GrafikEinstellungen.TextStandard).height + 2.00 * Rahmenabstand;
      
   end RahmenhöheErmitteln;
   
   
   
   function RahmenlängeErmitteln
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum)
      return Float
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.TextStandard,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), LängsterText)));
      
      RahmenlängeBerechnen := AktuellePosition.x + Sf.Graphics.Text.getLocalBounds (text => GrafikEinstellungen.TextStandard).width;
      
      if
        RahmenlängeBerechnen > Float (GrafikEinstellungen.FensterBreite)
      then
         return Float (GrafikEinstellungen.FensterBreite);
         
      else
         return RahmenlängeBerechnen;
      end if;
      
   end RahmenlängeErmitteln;
   
   
   
   procedure AnzeigeOhneAuswahl
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandMitteExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
   is begin
      
      null;
      
   end AnzeigeOhneAuswahl;

end TextAnzeigeSFML;

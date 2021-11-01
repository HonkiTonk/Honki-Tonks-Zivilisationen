pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;

with GlobaleTexte;

with GrafikAllgemein;
with GrafikEinstellungen;
with Eingabe;

package body AuswahlMenue is

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      WelchesMenü := WelchesMenüExtern;
      TextZugriff := GrafikEinstellungen.TextStandard;
      Anfang := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Anfangswert);
      Ende := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Endwert);
      AktuelleAuswahl := Anfang;
      
      case
        WelchesMenü
      is
         when SystemDatentypen.Haupt_Menü =>
            return Hauptmenü;
            
         when SystemDatentypen.Spiel_Menü =>
            return SystemDatentypen.Start_Weiter;
            
         when others =>
            return SystemDatentypen.Start_Weiter;
      end case;
      
   end AuswahlMenü;
   
   
   
   procedure Überschrift
     (ÜberschriftExtern : in Wide_Wide_String)
   is begin
            
      Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                         str  => ÜberschriftExtern);
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => 2 * GrafikEinstellungen.Schriftgröße);
      
      AktuellePosition := (TextMittelPositionErmitteln (TextZugriffExtern => TextZugriff), StartPositionYAchse);
      
      Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                    position => AktuellePosition);
      Sf.Graphics.Text.setColor (text  => TextZugriff,
                                 color => Sf.Graphics.Color.sfRed);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextZugriff);
      
   end Überschrift;
   
   
   
   function TextMittelPositionErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      return (Float (GrafikEinstellungen.FensterBreite) / 2.00 - Sf.Graphics.Text.getLocalBounds (text => TextZugriffExtern).width / 2.00);
      
   end TextMittelPositionErmitteln;
   
   
   
   function Hauptmenü
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      AuswahlSchleife:
      loop
         
         AnzeigeMenüSFML;
      
         case
           Eingabe.Tastenwert
         is
            when SystemDatentypen.Oben | SystemDatentypen.Ebene_Hoch =>
               if
                 AktuelleAuswahl = Anfang
               then
                  AktuelleAuswahl := Ende;

               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when SystemDatentypen.Unten | SystemDatentypen.Ebene_Runter =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anfang;

               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when SystemDatentypen.Auswählen =>
               if
                 AktuelleAuswahl = Anfang
               then
                  return SystemDatentypen.Start_Weiter;
                  
               elsif
                 AktuelleAuswahl = 4
               then
                  return SystemDatentypen.Laden;
                    
               elsif
                 AktuelleAuswahl = 5
               then
                  return SystemDatentypen.Optionen;
                    
               elsif
                 AktuelleAuswahl = 6
               then
                  return SystemDatentypen.Informationen;
                    
               elsif
                 AktuelleAuswahl = 7
               then
                  return SystemDatentypen.Würdigungen;
                    
               elsif
                 AktuelleAuswahl = Ende
               then
                  return SystemDatentypen.Spiel_Beenden;
                    
               else
                  raise Program_Error;
               end if;
                     
            when others =>
               null;
         end case;
         
         MausAuswahl;
         
      end loop AuswahlSchleife;
      
   end Hauptmenü;
   
   
   
   procedure MausAuswahl
   is begin
      
      MausZeigerPosition := Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster);
      
      Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Hauptmenü (1)));
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => 2 * GrafikEinstellungen.Schriftgröße);
      TextPositionMaus := StartPositionYAchse + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + 1.25 * Float (GrafikEinstellungen.Schriftgröße);
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => GrafikEinstellungen.Schriftgröße);
      
      MausZeigerSchleife:
      for ZeileSchleifenwert in Anfang .. Ende loop
                  
         StringSetzen (WelcheZeileExtern => ZeileSchleifenwert);
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus)
           .. Sf.sfInt32 (TextPositionMaus + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height)
         then
            AktuelleAuswahl := ZeileSchleifenwert;
            return;
         
         else
            TextPositionMaus := TextPositionMaus + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + 1.25 * Float (GrafikEinstellungen.Schriftgröße);
         end if;
         
      end loop MausZeigerSchleife;
      
   end MausAuswahl;
   
   
   
   procedure AnzeigeMenüSFML
   is begin
      
      AktuellePosition := (0.00, 0.00);
            
      GrafikAllgemein.FensterLeeren;
      
      Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => GlobaleTexte.Hauptmenü (1)));
      
      AnzeigeSchleife:
      for TextSchleifenwert in Anfang .. Ende loop
         
         AktuellePosition.y := AktuellePosition.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + 1.25 * Float (GrafikEinstellungen.Schriftgröße);
      
         Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                            size => GrafikEinstellungen.Schriftgröße);
         StringSetzen (WelcheZeileExtern => TextSchleifenwert);
         
         AktuellePosition.x := TextMittelPositionErmitteln (TextZugriffExtern => TextZugriff);
         
         Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                       position => AktuellePosition);
         
         if
           AktuelleAuswahl = TextSchleifenwert
         then
            Sf.Graphics.Text.setColor (text  => TextZugriff,
                                       color => Sf.Graphics.Color.sfGreen);
            
         else
            Sf.Graphics.Text.setColor (text  => TextZugriff,
                                       color => Sf.Graphics.Color.sfWhite);
         end if;
            
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                            text         => TextZugriff);
         
      end loop AnzeigeSchleife;
        
      GrafikAllgemein.FensterAnzeigen;
      
   end AnzeigeMenüSFML;
   
   
   
   procedure StringSetzen
     (WelcheZeileExtern : in Positive)
   is begin
      
      case
        WelchesMenü
      is
         when SystemDatentypen.Haupt_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Hauptmenü (WelcheZeileExtern)));
            
         when SystemDatentypen.Spiel_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Spielmenü (WelcheZeileExtern)));
            
         when others =>
            null;
      end case;
      
   end StringSetzen;

end AuswahlMenue;

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
      Auswahl;
   
      case
        WelchesMenü
      is
         when SystemDatentypen.Haupt_Menü =>
            return Hauptmenü;
            
         when SystemDatentypen.Spiel_Menü =>
            return Spielmenü;
            
         when SystemDatentypen.Optionen_Menü =>
            return Optionsmenü;
            
         when SystemDatentypen.Kartengröße_Menü =>
            return KartengrößeAuswählen;
            
         when SystemDatentypen.Kartenart_Menü =>
            return KartenartAuswählen;
            
         when SystemDatentypen.Kartenform_Menü =>
            return KartenformAuswählen;
            
         when SystemDatentypen.Kartentemperatur_Menü =>
            return KartentemperaturAuswählen;
            
         when SystemDatentypen.Kartenressourcen_Menü =>
            return KartenRessourcenAuswählen;
            
         when SystemDatentypen.Schwierigkeitsgrad_Menü =>
            return SchwierigkeitsgradAuswählen;
            
         when SystemDatentypen.Spieleranzahl_Menü =>
            return SpieleranzahlAuswählen;
                        
         when SystemDatentypen.Rassen_Menü =>
            return RasseAuswählen;
      end case;
      
   end AuswahlMenü;
   
   
   
   procedure Überschrift
   is begin
            
      StringSetzen (WelcheZeileExtern => 1);
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
   
   
   
   procedure Auswahl
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
               return;
            
            when others =>
               null;
         end case;
      
         MausAuswahl;
         
      end loop AuswahlSchleife;
      
   end Auswahl;
   
   
   
   function Hauptmenü
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
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
      
   end Hauptmenü;
   
   
   
   function Spielmenü
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahl = Anfang
      then
         return SystemDatentypen.Start_Weiter;
                    
      elsif
        AktuelleAuswahl = 3
      then
         return SystemDatentypen.Speichern;
                    
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
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         raise Program_Error;
      end if;
      
   end Spielmenü;
   
   
   
   function Optionsmenü
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahl = Anfang
      then
         return SystemDatentypen.Grafik;
                    
      elsif
        AktuelleAuswahl = 3
      then
         return SystemDatentypen.Sound;
                    
      elsif
        AktuelleAuswahl = 4
      then
         return SystemDatentypen.Steuerung;
                    
      elsif
        AktuelleAuswahl = 5
      then
         return SystemDatentypen.Sonstiges;
                    
      elsif
        AktuelleAuswahl = 6
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = 7
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         raise Program_Error;
      end if;
      
   end Optionsmenü;
   
   
      
   function KartengrößeAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahl = Anfang
      then
         return SystemDatentypen.Karte_Größe_20_20;
                    
      elsif
        AktuelleAuswahl = 3
      then
         return SystemDatentypen.Karte_Größe_40_40;
                    
      elsif
        AktuelleAuswahl = 4
      then
         return SystemDatentypen.Karte_Größe_80_80;
                    
      elsif
        AktuelleAuswahl = 5
      then
         return SystemDatentypen.Karte_Größe_120_80;
                    
      elsif
        AktuelleAuswahl = 6
      then
         return SystemDatentypen.Karte_Größe_120_160;
                    
      elsif
        AktuelleAuswahl = 7
      then
         return SystemDatentypen.Karte_Größe_160_160;
                    
      elsif
        AktuelleAuswahl = 8
      then
         return SystemDatentypen.Karte_Größe_240_240;
                    
      elsif
        AktuelleAuswahl = 9
      then
         return SystemDatentypen.Karte_Größe_320_320;
                    
      elsif
        AktuelleAuswahl = 10
      then
         return SystemDatentypen.Karte_Größe_1000_1000;
                    
      elsif
        AktuelleAuswahl = 11
      then
         return SystemDatentypen.Karte_Größe_Nutzer;
                    
      elsif
        AktuelleAuswahl = 12
      then
         return SystemDatentypen.Karte_Größe_Zufall;
                    
      elsif
        AktuelleAuswahl = 13
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         raise Program_Error;
      end if;
      
   end KartengrößeAuswählen;
   
   
   
   function KartenartAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahl = Anfang
      then
         return SystemDatentypen.Karte_Art_Inseln;
                    
      elsif
        AktuelleAuswahl = 3
      then
         return SystemDatentypen.Karte_Art_Kontinente;
                    
      elsif
        AktuelleAuswahl = 4
      then
         return SystemDatentypen.Karte_Art_Pangäa;
                    
      elsif
        AktuelleAuswahl = 5
      then
         return SystemDatentypen.Karte_Art_Nur_Land;
                    
      elsif
        AktuelleAuswahl = 6
      then
         return SystemDatentypen.Karte_Art_Chaos;
                    
      elsif
        AktuelleAuswahl = 7
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = 8
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = 9
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         raise Program_Error;
      end if;
      
   end KartenartAuswählen;
   
   
   
   function KartenformAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahl = Anfang
      then
         return SystemDatentypen.Karte_Form_X_Zylinder;
                    
      elsif
        AktuelleAuswahl = 3
      then
         return SystemDatentypen.Karte_Form_Y_Zylinder;
                    
      elsif
        AktuelleAuswahl = 4
      then
         return SystemDatentypen.Karte_Form_Torus;
                    
      elsif
        AktuelleAuswahl = 5
      then
         return SystemDatentypen.Karte_Form_Kugel;
                    
      elsif
        AktuelleAuswahl = 6
      then
         return SystemDatentypen.Karte_Form_Viereck;
                    
      elsif
        AktuelleAuswahl = 7
      then
         return SystemDatentypen.Karte_Form_Kugel_Gedreht;
                    
      elsif
        AktuelleAuswahl = 8
      then
         return SystemDatentypen.Karte_Form_Tugel;
                    
      elsif
        AktuelleAuswahl = 9
      then
         return SystemDatentypen.Karte_Form_Tugel_Gedreht;
                    
      elsif
        AktuelleAuswahl = 10
      then
         return SystemDatentypen.Karte_Form_Tugel_Extrem;
                    
      elsif
        AktuelleAuswahl = 11
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = 12
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         raise Program_Error;
      end if;
      
   end KartenformAuswählen;
   
   
   
   function KartentemperaturAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahl = Anfang
      then
         return SystemDatentypen.Karte_Temperatur_Kalt;
                    
      elsif
        AktuelleAuswahl = 3
      then
         return SystemDatentypen.Karte_Temperatur_Gemäßigt;
                    
      elsif
        AktuelleAuswahl = 4
      then
         return SystemDatentypen.Karte_Temperatur_Heiß;
                    
      elsif
        AktuelleAuswahl = 5
      then
         return SystemDatentypen.Karte_Temperatur_Eiszeit;
                    
      elsif
        AktuelleAuswahl = 6
      then
         return SystemDatentypen.Karte_Temperatur_Wüste;
                    
      elsif
        AktuelleAuswahl = 7
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = 8
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = 9
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         raise Program_Error;
      end if;
      
   end KartentemperaturAuswählen;
   
   
   
   function KartenRessourcenAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahl = Anfang
      then
         return SystemDatentypen.Karte_Ressource_Arm;
                    
      elsif
        AktuelleAuswahl = 3
      then
         return SystemDatentypen.Karte_Ressource_Wenig;
                    
      elsif
        AktuelleAuswahl = 4
      then
         return SystemDatentypen.Karte_Ressource_Mittel;
                    
      elsif
        AktuelleAuswahl = 5
      then
         return SystemDatentypen.Karte_Ressource_Viel;
                    
      elsif
        AktuelleAuswahl = 6
      then
         return SystemDatentypen.Karte_Ressource_Überfluss;
                    
      elsif
        AktuelleAuswahl = 7
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = 8
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         raise Program_Error;
      end if;
      
   end KartenRessourcenAuswählen;
   
   
   
   function SchwierigkeitsgradAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahl = Anfang
      then
         return SystemDatentypen.Schwierigkeitsgrad_Leicht;
                    
      elsif
        AktuelleAuswahl = 3
      then
         return SystemDatentypen.Schwierigkeitsgrad_Mittel;
                    
      elsif
        AktuelleAuswahl = 4
      then
         return SystemDatentypen.Schwierigkeitsgrad_Schwer;
                    
      elsif
        AktuelleAuswahl = 5
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = 6
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = 7
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         raise Program_Error;
      end if;
      
   end SchwierigkeitsgradAuswählen;
   
   
   
   function SpieleranzahlAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahl = Anfang
      then
         return SystemDatentypen.Eingabe;
                    
      elsif
        AktuelleAuswahl = 3
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = 4
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = 5
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         raise Program_Error;
      end if;
      
   end SpieleranzahlAuswählen;
   
   
   
   function RasseAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahl = Anfang
      then
         return SystemDatentypen.Menschen;
                    
      elsif
        AktuelleAuswahl = 3
      then
         return SystemDatentypen.Kasrodiah;
                    
      elsif
        AktuelleAuswahl = 4
      then
         return SystemDatentypen.Lasupin;
                    
      elsif
        AktuelleAuswahl = 5
      then
         return SystemDatentypen.Lamustra;
                    
      elsif
        AktuelleAuswahl = 6
      then
         return SystemDatentypen.Manuky;
                    
      elsif
        AktuelleAuswahl = 7
      then
         return SystemDatentypen.Suroka;
                    
      elsif
        AktuelleAuswahl = 8
      then
         return SystemDatentypen.Pryolon;
                    
      elsif
        AktuelleAuswahl = 9
      then
         return SystemDatentypen.Talbidahr;
                    
      elsif
        AktuelleAuswahl = 10
      then
         return SystemDatentypen.Moru_Phisihl;
                    
      elsif
        AktuelleAuswahl = 11
      then
         return SystemDatentypen.Larinos_Lotaris;
                    
      elsif
        AktuelleAuswahl = 12
      then
         return SystemDatentypen.Carupex;
                    
      elsif
        AktuelleAuswahl = 13
      then
         return SystemDatentypen.Alary;
                    
      elsif
        AktuelleAuswahl = 14
      then
         return SystemDatentypen.Tesorahn;
                    
      elsif
        AktuelleAuswahl = 15
      then
         return SystemDatentypen.Natries_Zermanis;
                    
      elsif
        AktuelleAuswahl = 16
      then
         return SystemDatentypen.Tridatus;
                    
      elsif
        AktuelleAuswahl = 17
      then
         return SystemDatentypen.Senelari;
                    
      elsif
        AktuelleAuswahl = 18
      then
         return SystemDatentypen.Aspari_2;
                    
      elsif
        AktuelleAuswahl = 19
      then
         return SystemDatentypen.Ekropa;
                    
      elsif
        AktuelleAuswahl = 20
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = 21
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = 22
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         raise Program_Error;
      end if;
      
   end RasseAuswählen;
   
         
   
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
      
      Überschrift;
      
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
            
         when SystemDatentypen.Optionen_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Optionsmenü (WelcheZeileExtern)));
            
         when SystemDatentypen.Kartengröße_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Kartengröße (WelcheZeileExtern)));
            
         when SystemDatentypen.Kartenart_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Kartenart (WelcheZeileExtern)));
            
         when SystemDatentypen.Kartenform_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Kartenform (WelcheZeileExtern)));
            
         when SystemDatentypen.Kartentemperatur_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Kartentemperatur (WelcheZeileExtern)));
            
         when SystemDatentypen.Kartenressourcen_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Ressourcenmenge (WelcheZeileExtern)));
            
         when SystemDatentypen.Schwierigkeitsgrad_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Schwierigkeitsgrad (WelcheZeileExtern)));
            
         when SystemDatentypen.Spieleranzahl_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Spieleranzahl (WelcheZeileExtern)));
                        
         when SystemDatentypen.Rassen_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Rassenauswahl (WelcheZeileExtern)));
      end case;
      
   end StringSetzen;

end AuswahlMenue;

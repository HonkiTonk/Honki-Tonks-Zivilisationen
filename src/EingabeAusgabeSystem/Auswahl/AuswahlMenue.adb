pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;

with GlobaleTexte;

with GrafikAllgemein;
with GrafikEinstellungen;
with Eingabe;
with AllgemeineTextBerechnungenSFML;

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
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungen.Schriftgröße);
      
      case
        WelchesMenü
      is
         when SystemDatentypen.Haupt_Menü =>
            AnzeigeStartwert := 1;
            
         when others =>
            AnzeigeStartwert := 0;
      end case;
      
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
                        
         when SystemDatentypen.Rassen_Menü =>
            return RasseAuswählen;
      end case;
      
   end AuswahlMenü;
   
   
   
   procedure Überschrift
   is begin
            
      StringSetzen (WelcheZeileExtern => 1);
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungen.Schriftgröße)));
      
      AktuellePosition := (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextZugriffExtern => TextZugriff), StartPositionYAchse);
      
      Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                    position => AktuellePosition);
      Sf.Graphics.Text.setColor (text  => TextZugriff,
                                 color => Sf.Graphics.Color.sfRed);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextZugriff);
      
   end Überschrift;
   
         
   
   procedure MausAuswahl
   is begin
      
      MausZeigerPosition := Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster);
      
      StringSetzen (WelcheZeileExtern => 1);
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungen.Schriftgröße)));
      TextPositionMaus.y := StartPositionYAchse + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + ZeilenAbstand;
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => GrafikEinstellungen.Schriftgröße);
      
      MausZeigerSchleife:
      for ZeileSchleifenwert in Anfang .. Ende loop
                  
         StringSetzen (WelcheZeileExtern => ZeileSchleifenwert);
         
         case
           (ZeileSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               TextPositionMaus.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => TextZugriff,
                                                                   LinksRechtsExtern => False);
               
            when others =>
               TextPositionMaus.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => TextZugriff,
                                                                   LinksRechtsExtern => True);
         end case;
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus.y)
           .. Sf.sfInt32 (TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height)
           and
             MausZeigerPosition.x in Sf.sfInt32 (TextPositionMaus.x) .. Sf.sfInt32 (TextPositionMaus.x + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).width)
         then
            AktuelleAuswahl := ZeileSchleifenwert;
            return;
         
         else
            null;
         end if;
         
         case
           (ZeileSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               null;
               
            when others =>
               TextPositionMaus.y := TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + ZeilenAbstand;
         end case;   
                  
      end loop MausZeigerSchleife;
      
   end MausAuswahl;
   
   
   
   procedure AnzeigeMenüSFML
   is begin
      
      AktuellePosition := (0.00, 0.00);
            
      GrafikAllgemein.FensterLeeren;
      
      Überschrift;
      AktuellePosition.y := AktuellePosition.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + ZeilenAbstand;
      
      AnzeigeSchleife:
      for TextSchleifenwert in Anfang .. Ende loop
      
         Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                            size => GrafikEinstellungen.Schriftgröße);
         StringSetzen (WelcheZeileExtern => TextSchleifenwert);
         
         case
           (TextSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               AktuellePosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => TextZugriff,
                                                                   LinksRechtsExtern => False);
               
            when others =>
               AktuellePosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => TextZugriff,
                                                                   LinksRechtsExtern => True);
         end case;
         
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
         
         case
           (TextSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               null;
               
            when others =>
               AktuellePosition.y := AktuellePosition.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + ZeilenAbstand;
         end case;
         
      end loop AnzeigeSchleife;
      
      WeiterenTextAnzeigen;
      
      GrafikAllgemein.FensterAnzeigen;
      
   end AnzeigeMenüSFML;
   
   
   
   procedure WeiterenTextAnzeigen
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => GrafikEinstellungen.Schriftgröße);
      StringSetzen (WelcheZeileExtern => AktuelleAuswahl + 1 + (Ende - Anfang));
      Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                    position => (10.00, 400.00));
      Sf.Graphics.Text.setColor (text  => TextZugriff,
                                 color => Sf.Graphics.Color.sfWhite);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextZugriff);
      
   end WeiterenTextAnzeigen;
   
   
   
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
                        
         when SystemDatentypen.Rassen_Menü =>
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Rassenauswahl (WelcheZeileExtern)));
      end case;
      
   end StringSetzen;

      
   
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
               
               -- Später noch erweitern?
            when SystemDatentypen.Links =>
               null;
               
            when SystemDatentypen.Rechts =>
               null;
                              
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
        AktuelleAuswahl = Anfang + 1
      then
         return SystemDatentypen.Laden;
                    
      elsif
        AktuelleAuswahl = Anfang + 2
      then
         return SystemDatentypen.Optionen;
                    
      elsif
        AktuelleAuswahl = Anfang + 3
      then
         return SystemDatentypen.Informationen;
                    
      elsif
        AktuelleAuswahl = Anfang + 4
      then
         return SystemDatentypen.Würdigungen;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahl not in Anfang .. Ende
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
        AktuelleAuswahl = Anfang + 1
      then
         return SystemDatentypen.Speichern;
                    
      elsif
        AktuelleAuswahl = Anfang + 2
      then
         return SystemDatentypen.Laden;
                    
      elsif
        AktuelleAuswahl = Anfang + 3
      then
         return SystemDatentypen.Optionen;
                    
      elsif
        AktuelleAuswahl = Anfang + 4
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahl not in Anfang .. Ende
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
        AktuelleAuswahl = Anfang + 1
      then
         return SystemDatentypen.Sound;
                    
      elsif
        AktuelleAuswahl = Anfang + 2
      then
         return SystemDatentypen.Steuerung;
                    
      elsif
        AktuelleAuswahl = Anfang + 3
      then
         return SystemDatentypen.Sonstiges;
                    
      elsif
        AktuelleAuswahl = Anfang + 4
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = Anfang + 5
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahl not in Anfang .. Ende
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
        AktuelleAuswahl = Anfang + 1
      then
         return SystemDatentypen.Karte_Größe_40_40;
                    
      elsif
        AktuelleAuswahl = Anfang + 2
      then
         return SystemDatentypen.Karte_Größe_80_80;
                    
      elsif
        AktuelleAuswahl = Anfang + 3
      then
         return SystemDatentypen.Karte_Größe_120_80;
                    
      elsif
        AktuelleAuswahl = Anfang + 4
      then
         return SystemDatentypen.Karte_Größe_120_160;
                    
      elsif
        AktuelleAuswahl = Anfang + 5
      then
         return SystemDatentypen.Karte_Größe_160_160;
                    
      elsif
        AktuelleAuswahl = Anfang + 6
      then
         return SystemDatentypen.Karte_Größe_240_240;
                    
      elsif
        AktuelleAuswahl = Anfang + 7
      then
         return SystemDatentypen.Karte_Größe_320_320;
                    
      elsif
        AktuelleAuswahl = Anfang + 8
      then
         return SystemDatentypen.Karte_Größe_1000_1000;
                    
      elsif
        AktuelleAuswahl = Anfang + 9
      then
         return SystemDatentypen.Karte_Größe_Nutzer;
                    
      elsif
        AktuelleAuswahl = Anfang + 10
      then
         return SystemDatentypen.Karte_Größe_Zufall;
                    
      elsif
        AktuelleAuswahl = Anfang + 11
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahl not in Anfang .. Ende
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
        AktuelleAuswahl = Anfang + 1
      then
         return SystemDatentypen.Karte_Art_Kontinente;
                    
      elsif
        AktuelleAuswahl = Anfang + 2
      then
         return SystemDatentypen.Karte_Art_Pangäa;
                    
      elsif
        AktuelleAuswahl = Anfang + 3
      then
         return SystemDatentypen.Karte_Art_Nur_Land;
                    
      elsif
        AktuelleAuswahl = Anfang + 4
      then
         return SystemDatentypen.Karte_Art_Chaos;
                    
      elsif
        AktuelleAuswahl = Anfang + 5
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = Anfang + 6
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = Anfang + 7
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahl not in Anfang .. Ende
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
        AktuelleAuswahl = Anfang + 1
      then
         return SystemDatentypen.Karte_Form_Y_Zylinder;
                    
      elsif
        AktuelleAuswahl = Anfang + 2
      then
         return SystemDatentypen.Karte_Form_Torus;
                    
      elsif
        AktuelleAuswahl = Anfang + 3
      then
         return SystemDatentypen.Karte_Form_Kugel;
                    
      elsif
        AktuelleAuswahl = Anfang + 4
      then
         return SystemDatentypen.Karte_Form_Viereck;
                    
      elsif
        AktuelleAuswahl = Anfang + 5
      then
         return SystemDatentypen.Karte_Form_Kugel_Gedreht;
                    
      elsif
        AktuelleAuswahl = Anfang + 6
      then
         return SystemDatentypen.Karte_Form_Tugel;
                    
      elsif
        AktuelleAuswahl = Anfang + 7
      then
         return SystemDatentypen.Karte_Form_Tugel_Gedreht;
                    
      elsif
        AktuelleAuswahl = Anfang + 8
      then
         return SystemDatentypen.Karte_Form_Tugel_Extrem;
                    
      elsif
        AktuelleAuswahl = Anfang + 9
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = Anfang + 10
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahl not in Anfang .. Ende
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
        AktuelleAuswahl = Anfang + 1
      then
         return SystemDatentypen.Karte_Temperatur_Gemäßigt;
                    
      elsif
        AktuelleAuswahl = Anfang + 2
      then
         return SystemDatentypen.Karte_Temperatur_Heiß;
                    
      elsif
        AktuelleAuswahl = Anfang + 3
      then
         return SystemDatentypen.Karte_Temperatur_Eiszeit;
                    
      elsif
        AktuelleAuswahl = Anfang + 4
      then
         return SystemDatentypen.Karte_Temperatur_Wüste;
                    
      elsif
        AktuelleAuswahl = Anfang + 5
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = Anfang + 6
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = Anfang + 7
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahl not in Anfang .. Ende
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
        AktuelleAuswahl = Anfang + 1
      then
         return SystemDatentypen.Karte_Ressource_Wenig;
                    
      elsif
        AktuelleAuswahl = Anfang + 2
      then
         return SystemDatentypen.Karte_Ressource_Mittel;
                    
      elsif
        AktuelleAuswahl = Anfang + 3
      then
         return SystemDatentypen.Karte_Ressource_Viel;
                    
      elsif
        AktuelleAuswahl = Anfang + 4
      then
         return SystemDatentypen.Karte_Ressource_Überfluss;
                    
      elsif
        AktuelleAuswahl = Anfang + 5
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = Anfang + 6
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahl not in Anfang .. Ende
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
        AktuelleAuswahl = Anfang + 1
      then
         return SystemDatentypen.Schwierigkeitsgrad_Mittel;
                    
      elsif
        AktuelleAuswahl = Anfang + 2
      then
         return SystemDatentypen.Schwierigkeitsgrad_Schwer;
                    
      elsif
        AktuelleAuswahl = Anfang + 3
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = Anfang + 4
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = Anfang + 5
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahl not in Anfang .. Ende
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
        AktuelleAuswahl = Anfang + 1
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = Anfang + 2
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = Anfang + 3
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahl not in Anfang .. Ende
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
        AktuelleAuswahl = Anfang + 1
      then
         return SystemDatentypen.Kasrodiah;
                    
      elsif
        AktuelleAuswahl = Anfang + 2
      then
         return SystemDatentypen.Lasupin;
                    
      elsif
        AktuelleAuswahl = Anfang + 3
      then
         return SystemDatentypen.Lamustra;
                    
      elsif
        AktuelleAuswahl = Anfang + 4
      then
         return SystemDatentypen.Manuky;
                    
      elsif
        AktuelleAuswahl = Anfang + 5
      then
         return SystemDatentypen.Suroka;
                    
      elsif
        AktuelleAuswahl = Anfang + 6
      then
         return SystemDatentypen.Pryolon;
                    
      elsif
        AktuelleAuswahl = Anfang + 7
      then
         return SystemDatentypen.Talbidahr;
                    
      elsif
        AktuelleAuswahl = Anfang + 8
      then
         return SystemDatentypen.Moru_Phisihl;
                    
      elsif
        AktuelleAuswahl = Anfang + 9
      then
         return SystemDatentypen.Larinos_Lotaris;
                    
      elsif
        AktuelleAuswahl = Anfang + 10
      then
         return SystemDatentypen.Carupex;
                    
      elsif
        AktuelleAuswahl = Anfang + 11
      then
         return SystemDatentypen.Alary;
                    
      elsif
        AktuelleAuswahl = Anfang + 12
      then
         return SystemDatentypen.Tesorahn;
                    
      elsif
        AktuelleAuswahl = Anfang + 13
      then
         return SystemDatentypen.Natries_Zermanis;
                    
      elsif
        AktuelleAuswahl = Anfang + 14
      then
         return SystemDatentypen.Tridatus;
                    
      elsif
        AktuelleAuswahl = Anfang + 15
      then
         return SystemDatentypen.Senelari;
                    
      elsif
        AktuelleAuswahl = Anfang + 16
      then
         return SystemDatentypen.Aspari_2;
                    
      elsif
        AktuelleAuswahl = Anfang + 17
      then
         return SystemDatentypen.Ekropa;
                    
      elsif
        AktuelleAuswahl = Anfang + 18
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahl = Anfang + 19
      then
         return SystemDatentypen.Fertig;
                    
      elsif
        AktuelleAuswahl = Anfang + 20
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahl = Anfang + 21
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahl = Ende
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahl not in Anfang .. Ende
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
      end if;
      
   end RasseAuswählen;
   
end AuswahlMenue;

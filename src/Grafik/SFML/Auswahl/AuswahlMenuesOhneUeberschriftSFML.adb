pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
with Sf.Graphics.Color;
with Sf.Graphics.RenderWindow;

with SystemKonstanten;

with GrafikEinstellungenSFML;
with Fehler;

package body AuswahlMenuesOhneUeberschriftSFML is

   ------------------ In AuswahlMenüsOhneAlles umbenennen, ich brauche ja auch noch mit Überschrift ohne Zusatztext und mit Überschrift mit Zusatztext.
   procedure AuswahlMenüsOhneÜberschrift
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum)
   is begin
      
      TextBereich := Überschrift + EndeMenü (WelchesMenüExtern) + Versionsnummer;
      
      -- Prüfung ob ich das Positionsarray auch an geänderte Textarrays in GlobaleTexte angepasst habe.
      -- Einmal Überschrift + Texte + Versionsnummer
      if
        TextBereich > PositionenArray'Last (2)
      then
         Fehler.GrafikFehler (FehlermeldungExtern => "AuswahlMenuesOhneUeberschriftSFML.AuswahlMenüsOhneÜberschrift - PositionenArray ist zu kurz: " & WelchesMenüExtern'Wide_Wide_Image);
         
      else
         null;
      end if;
      
      AktuelleAuflösung := GrafikEinstellungenSFML.AktuelleFensterAuflösung;
      
      ----------------------- Muss auch bei Änderung der Schriftart, Schriftfarbe und Schriftgröße neu berechnet werden. Später was besseres bauen.
      if
        AktuelleAuflösung.x /= AuflösungBerechnet (WelchesMenüExtern).x
        or
          AktuelleAuflösung.y /= AuflösungBerechnet (WelchesMenüExtern).y
      then
         -- Hier Werte neu berechnen, dann können sie in Logik genutzt werden um die Mausposition direkt verwenden zu können ohne nochmal alles anlegen zu müssen.
         Positionsberechnung (WelchesMenüExtern => WelchesMenüExtern);
         
      else
         null;
      end if;
      
      case
        WelchesMenüExtern
      is
         when others =>
            null;
      end case;
   
      -- Abstand
      -- Spielename
      -- Abstand
      -- Auswahlmöglichkeiten
      -- Abstand
      -- Versionnummer
      -- Abstand
      
      TextSchleife:
      for TextSchleifenwert in Überschrift .. TextBereich loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextAccess (WelchesMenüExtern, TextSchleifenwert));
         
      end loop TextSchleife;
      
   end AuswahlMenüsOhneÜberschrift;
   
   
   
   procedure Positionsberechnung
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum)
   is begin
      
      -- Rechenwerte: Überschrift + Texte / 2 + Versionsnummer
      -- Positionswerte : Überschrift + Texte + Versionsnummer
      AktuelleAuflösungFloat.x := Float (AktuelleAuflösung.x);
      AktuelleAuflösungFloat.y := Float (AktuelleAuflösung.y);
      
      Rechenwert.y := Float (AktuelleAuflösung.y / 100);
      
      if
        Rechenwert.y < 1.00
      then
         Rechenwert.y := 1.00;
         
      else
         null;
      end if;
      
      Spielenamen (WelchesMenüExtern => WelchesMenüExtern);
      Auswahlmöglichkeiten (WelchesMenüExtern => WelchesMenüExtern);
      VersionsnummerText (WelchesMenüExtern => WelchesMenüExtern);
      
   end Positionsberechnung;
   
   
   
   procedure Spielenamen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, Überschrift),
                                         str  => SystemKonstanten.Spielename);
      
      ------------------- Könnte Probleme beim Ändern der Schriftgröße durch den Spieler führen, später was besseres bauen.
      Sf.Graphics.Text.setCharacterSize (text => TextAccess (WelchesMenüExtern, Überschrift),
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      ------------------- Könnte Probleme beim Ändern der Schriftfarbe durch den Spieler führen, später was besseres bauen.
      Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, Überschrift),
                                 color => Sf.Graphics.Color.sfRed);
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (WelchesMenüExtern, Überschrift),
                                    position => Rechenwert);
      
   end Spielenamen;
   
   
   
   procedure Auswahlmöglichkeiten
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, Überschrift),
                                         str  => SystemKonstanten.Spielename);
      
      ------------------- Könnte Probleme beim Ändern der Schriftgröße durch den Spieler führen, später was besseres bauen.
      Sf.Graphics.Text.setCharacterSize (text => TextAccess (WelchesMenüExtern, Überschrift),
                                         size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
      ------------------- Könnte Probleme beim Ändern der Schriftfarbe durch den Spieler führen, später was besseres bauen.
      Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, Überschrift),
                                 color => Sf.Graphics.Color.sfRed);
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (WelchesMenüExtern, Überschrift),
                                    position => Rechenwert);
      
   end Auswahlmöglichkeiten;
   
   
   
   procedure VersionsnummerText
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, TextBereich),
                                         str  => SystemKonstanten.Versionsnummer);
            
      ------------------- Könnte Probleme beim Ändern der Schriftgröße durch den Spieler führen, später was besseres bauen.
      Sf.Graphics.Text.setCharacterSize (text => TextAccess (WelchesMenüExtern, TextBereich),
                                         size => Sf.sfUint32 (0.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
            
      ------------------- Könnte Probleme beim Ändern der Schriftfarbe durch den Spieler führen, später was besseres bauen.
      Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, TextBereich),
                                 color => Sf.Graphics.Color.sfRed);
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (WelchesMenüExtern, TextBereich),
                                    position => Rechenwert);
      
   end VersionsnummerText;

end AuswahlMenuesOhneUeberschriftSFML;

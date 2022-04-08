pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
with Sf.Graphics.RenderWindow;

with SystemKonstanten;

with GrafikEinstellungenSFML;
with AllgemeineTextBerechnungenSFML;
with AuswahlMenue;

package body AuswahlMenuesOhneUeberschriftSFML is

   ------------------ In AuswahlMenüsOhneAlles umbenennen, ich brauche ja auch noch mit Überschrift ohne Zusatztext und mit Überschrift mit Zusatztext.
   procedure AuswahlMenüsOhneÜberschrift
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum)
   is begin
            
      TextBereich := Überschrift + EndeMenü (WelchesMenüExtern) + Versionsnummer;
                  
      AktuelleAuflösung := GrafikEinstellungenSFML.AktuelleFensterAuflösung;
      
      ----------------------- Muss auch bei Änderung der Schriftart, Schriftfarbe und Schriftgröße neu berechnet werden. Später was besseres bauen.
      if
        AktuelleAuflösung.x /= AuflösungBerechnet (WelchesMenüExtern).x
        or
          AktuelleAuflösung.y /= AuflösungBerechnet (WelchesMenüExtern).y
      then
         -- Hier Werte neu berechnen, dann können sie in Logik genutzt werden um die Mausposition direkt verwenden zu können ohne nochmal alles anlegen zu müssen.
         ZeilenAbstand := 0.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
         FontSchleife:
         for FontSchleifenwert in Überschrift .. TextBereich loop
            
            Sf.Graphics.Text.setFont (text => TextAccess (WelchesMenüExtern, FontSchleifenwert),
                                      font => GrafikEinstellungenSFML.SchriftartAccess);
            
         end loop FontSchleife;
                  
         Positionsberechnung (WelchesMenüExtern => WelchesMenüExtern);
         AuflösungBerechnet (WelchesMenüExtern) := AktuelleAuflösung;
         
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
      
      Rechenwert.y := Float (AktuelleAuflösung.y / 100);
      
      if
        Rechenwert.y < 20.00
      then
         Rechenwert.y := 20.00;
         
      else
         null;
      end if;
      
      Spielenamen (WelchesMenüExtern => WelchesMenüExtern);
      Auswahlmöglichkeiten (WelchesMenüExtern => WelchesMenüExtern);
      
      Rechenwert.y := Float (AktuelleAuflösung.y) - Float (AktuelleAuflösung.y / 50);
      
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
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (WelchesMenüExtern, Überschrift));
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (WelchesMenüExtern, Überschrift),
                                    position => Rechenwert);
      
      Rechenwert.y := Rechenwert.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess (WelchesMenüExtern, Überschrift)).height + ZeilenAbstand;
      
   end Spielenamen;
   
   
   
   procedure Auswahlmöglichkeiten
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum)
   is begin
            
      AnzeigeSchleife:
      for TextSchleifenwert in 1 .. EndeMenü (WelchesMenüExtern) loop
      
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, Überschrift + TextSchleifenwert),
                                            str  => AuswahlMenue.StringSetzen (WelcheZeileExtern => TextSchleifenwert,
                                                                               WelchesMenüExtern => WelchesMenüExtern));
         
         ------------------- Könnte Probleme beim Ändern der Schriftgröße durch den Spieler führen, später was besseres bauen.
         Sf.Graphics.Text.setCharacterSize (text => TextAccess (WelchesMenüExtern, Überschrift + TextSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
         ------------------- Könnte Probleme beim Ändern der Schriftfarbe durch den Spieler führen, später was besseres bauen.
         Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, Überschrift + TextSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
         case
           TextSchleifenwert mod 2
         is
            when 0 =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (WelchesMenüExtern, Überschrift + TextSchleifenwert),
                                                                                            LinksRechtsExtern => True);
               
            when others =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (WelchesMenüExtern, Überschrift + TextSchleifenwert),
                                                                                            LinksRechtsExtern => False);
         end case;
         
         Sf.Graphics.Text.setPosition (text     => TextAccess (WelchesMenüExtern, Überschrift + TextSchleifenwert),
                                       position => Rechenwert);
         
         case
           TextSchleifenwert mod 2
         is
            when 0 =>
               Rechenwert.y := Rechenwert.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess (WelchesMenüExtern, Überschrift)).height + ZeilenAbstand;
               
            when others =>
               null;
         end case;
         
         InteraktionAuswahl.Positionen (WelchesMenüExtern, TextSchleifenwert) := Sf.Graphics.Text.getLocalBounds (text => TextAccess (WelchesMenüExtern, Überschrift + TextSchleifenwert));
         
      end loop AnzeigeSchleife;
      
   end Auswahlmöglichkeiten;
   
   
   
   procedure VersionsnummerText
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, TextBereich),
                                         str  => "Version: " & SystemKonstanten.Versionsnummer);
            
      ------------------- Könnte Probleme beim Ändern der Schriftgröße durch den Spieler führen, später was besseres bauen.
      Sf.Graphics.Text.setCharacterSize (text => TextAccess (WelchesMenüExtern, TextBereich),
                                         size => Sf.sfUint32 (0.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
            
      ------------------- Könnte Probleme beim Ändern der Schriftfarbe durch den Spieler führen, später was besseres bauen.
      Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, TextBereich),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeSonstigerText);
      
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (WelchesMenüExtern, TextBereich));
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (WelchesMenüExtern, TextBereich),
                                    position => Rechenwert);
      
   end VersionsnummerText;

end AuswahlMenuesOhneUeberschriftSFML;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
with Sf.Graphics.Color; use Sf.Graphics.Color;
with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with SystemDatentypen; use SystemDatentypen;
with SonstigesKonstanten;

with GrafikEinstellungenSFML;
with AllgemeineTextBerechnungenSFML;
with AuswahlMenuesStringsSetzen;
with AuswahlMenuesEinfach;
with AuswahlMenuesZusatztextSFML;
with EingeleseneTexturenSFML;
with TexturenSetzenSkalierenSFML;

package body AuswahlMenuesEinfachSFML is

   procedure AuswahlMenüsEinfach
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum)
   is begin
      
      MenüHintergrund (WelchesMenüExtern => WelchesMenüExtern);
            
      --------------------- SystemKonstanten.EndeMenü (WelchesMenüExtern) durch internes Ende ersetzen und das dann immer mitübergeben?
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Menü_Zusatztext_Enum'Range =>
            -- 'Floor sorgt dafür das Ada das Ergebnis abrundet. Alternativ würde HIER IN DIESEM FALL (NICHT ALLGEMEIN) auch - 1 funktionieren.
            Textbereich := Überschrift + Integer (Float'Floor (0.50 * Float (SystemKonstanten.EndeMenü (WelchesMenüExtern)))) + Versionsnummer;
            
         when others => 
            Textbereich := Überschrift + SystemKonstanten.EndeMenü (WelchesMenüExtern) + Versionsnummer;
      end case;
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Menü_Ohne_Überschrift_Enum'Range =>
            HauptmenüAbzug := 1;
            SchleifenAbzug := 0;
            
         when others =>
            HauptmenüAbzug := 0;
            SchleifenAbzug := 1;
      end case;
      
      Textbearbeitung (WelchesMenüExtern => WelchesMenüExtern,
                       TextbereichExtern  => Textbereich);
      
      TextSchleife:
      for TextSchleifenwert in Überschrift .. Textbereich loop
         
         -- Da der Textbereich bei jedem Aufruf weiter oben neu ermittelt wird, sollte niemals ein Zugriff außerhalbt des gültigen Bereichs erfolgen.
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextAccess (WelchesMenüExtern, TextSchleifenwert));
         
      end loop TextSchleife;
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Menü_Zusatztext_Enum'Range =>
            -- Aktuelle Auswahl gleich mitübergeben?
            AuswahlMenuesZusatztextSFML.AuswahlMenüsZusatztext (WelchesMenüExtern => WelchesMenüExtern);
            
         when others =>
            null;
      end case;
      
   end AuswahlMenüsEinfach;
   
   
   
   procedure MenüHintergrund
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum)
   is begin
      
      if
        EingeleseneTexturenSFML.MenüHintergrundAccess (WelchesMenüExtern) /= null
      then
         Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccess,
                                         position => (0.00, 0.00));
         Sf.Graphics.Sprite.scale (sprite  => SpriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenGesamtesBild (SpriteAccessExtern  => SpriteAccess,
                                                                                                               TextureAccessExtern => EingeleseneTexturenSFML.MenüHintergrundAccess (WelchesMenüExtern)));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => SpriteAccess);
         
      else
         null;
      end if;
      
   end MenüHintergrund;
   
   
   
   procedure Textbearbeitung
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin
      
      AktuelleAuflösung := GrafikEinstellungenSFML.AktuelleFensterAuflösung;
      AktuelleSchriftgröße := GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße;
      AktuelleSchriftfarben := GrafikEinstellungenSFML.Schriftfarben;

      case
        SchriftartFestgelegt (WelchesMenüExtern)
      is
         when False =>
            FontSchleife:
            for FontSchleifenwert in Überschrift .. TextbereichExtern loop
            
               Sf.Graphics.Text.setFont (text => TextAccess (WelchesMenüExtern, FontSchleifenwert),
                                         font => GrafikEinstellungenSFML.SchriftartAccess);
            
            end loop FontSchleife;
            
            SchriftartFestgelegt (WelchesMenüExtern) := True;
            
         when True =>
            null;
      end case;
      
      if
        AktuelleSchriftgröße /= SchriftgrößeFestgelegt (WelchesMenüExtern)
      then
         SchriftgrößenFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                                   TextbereichExtern => TextbereichExtern);
         
         SchriftgrößeFestgelegt (WelchesMenüExtern) := AktuelleSchriftgröße;

      else
         null;
      end if;
      
      case
        TextFestgelegt (WelchesMenüExtern)
      is
         when False =>
            TextFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                           TextbereichExtern => TextbereichExtern);
            
            TextFestgelegt (WelchesMenüExtern) := True;
            
         when True =>
            null;
      end case;
      
      ------------------- Bessere Lösung für die Zurücksetzung der ausgewählten Menüoption einbauen, als alles zurückzusetzen. 
      if
        AktuelleSchriftfarben.FarbeÜberschrift /= SchriftfarbenFestgelegt (WelchesMenüExtern).FarbeÜberschrift
        or
          AktuelleSchriftfarben.FarbeStandardText /= SchriftfarbenFestgelegt (WelchesMenüExtern).FarbeStandardText
        or
          AktuelleSchriftfarben.FarbeAusgewähltText /= SchriftfarbenFestgelegt (WelchesMenüExtern).FarbeAusgewähltText
        or
          AktuelleSchriftfarben.FarbeMenschText /= SchriftfarbenFestgelegt (WelchesMenüExtern).FarbeMenschText
        or
          AktuelleSchriftfarben.FarbeKIText /= SchriftfarbenFestgelegt (WelchesMenüExtern).FarbeKIText
        or
          AktuelleSchriftfarben.FarbeSonstigerText /= SchriftfarbenFestgelegt (WelchesMenüExtern).FarbeSonstigerText
        or
          LetztesMenü /= WelchesMenüExtern
      then
         SchriftfarbenFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                                 TextbereichExtern => TextbereichExtern);
         
         SchriftfarbenFestgelegt (WelchesMenüExtern) := AktuelleSchriftfarben;
         LetztesMenü := WelchesMenüExtern;
         
      else
         null;
      end if;
      
      AktuelleAuswahl := AuswahlMenuesEinfach.AktuelleAuswahl;
              
      if
        AktuelleAuswahl /= LetzteAuswahl
      then
         FarbeAktuelleAuswahlFestlegen (WelchesMenüExtern     => WelchesMenüExtern,
                                        AktuelleAuswahlExtern => AktuelleAuswahl,
                                        LetzteAuswahlExtern   => LetzteAuswahl);
         
         LetzteAuswahl := AktuelleAuswahl;
         
      else
         null;
      end if;
      
      -- Textpositionierung immer am Schluss durchführen, dann ist auf jeden Fall alles wichtige (z. B. Schriftart, Schriftgröße, usw.) bereits festgelegt.
      if
        AktuelleAuflösung.x /= AuflösungBerechnet (WelchesMenüExtern).x
        or
          AktuelleAuflösung.y /= AuflösungBerechnet (WelchesMenüExtern).y
      then
         SchriftpositionFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                                   TextbereichExtern => TextbereichExtern);
         
         AuflösungBerechnet (WelchesMenüExtern) := AktuelleAuflösung;
         
      else
         null;
      end if;
      
   end Textbearbeitung;



   procedure SchriftgrößenFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin

      Sf.Graphics.Text.setCharacterSize (text => TextAccess (WelchesMenüExtern, Überschrift),
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextAccess (WelchesMenüExtern, Überschrift + SchriftgrößeSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop SchriftgrößeSchleife;
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess (WelchesMenüExtern, TextbereichExtern),
                                         size => Sf.sfUint32 (0.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));

   end SchriftgrößenFestlegen;



   procedure SchriftfarbenFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, Überschrift),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop
         
         Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, Überschrift + SchriftfarbeSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop SchriftfarbeSchleife;
      
      Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, TextbereichExtern),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeSonstigerText);

   end SchriftfarbenFestlegen;
   
   
   
   procedure FarbeAktuelleAuswahlFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      LetzteAuswahlExtern : in Natural)
   is begin
                
      case
        LetzteAuswahlExtern
      is
         when SystemKonstanten.LeerAuswahl =>
            null;
            
         when others =>
            Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, LetzteAuswahlExtern + Überschrift),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
      end case;
      
      case
        AktuelleAuswahlExtern
      is
         when SystemKonstanten.LeerAuswahl =>
            null;
            
         when others =>
            Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, AktuelleAuswahlExtern + Überschrift),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
      end case;
      
   end FarbeAktuelleAuswahlFestlegen;
   
   
   
   procedure TextFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Menü_Ohne_Überschrift_Enum'Range =>
            Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, Überschrift),
                                               str  => SonstigesKonstanten.Spielename);
            
         when SystemDatentypen.Menü_Mit_Überschrift_Enum'Range | SystemDatentypen.Menü_Zusatztext_Enum'Range =>
            Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, Überschrift),
                                               str  => AuswahlMenuesStringsSetzen.StringSetzen (WelcheZeileExtern => Überschrift,
                                                                                                WelchesMenüExtern => WelchesMenüExtern));
      end case;
      
      TextSchleife:
      for TextSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop
                  
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, Überschrift + TextSchleifenwert),
                                            str  => AuswahlMenuesStringsSetzen.StringSetzen (WelcheZeileExtern => Überschrift + TextSchleifenwert - HauptmenüAbzug,
                                                                                             WelchesMenüExtern => WelchesMenüExtern));
         
      end loop TextSchleife;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, TextbereichExtern),
                                         str  => "Version: " & SonstigesKonstanten.Versionsnummer);
      
   end TextFestlegen;
   
   
   
   ------------------------- Später noch die Berechnung für verschiedene Auflösungen einbauen, so dass die Texte immer reinpassen.
   ------------------------- Dafür ist vermutlich auch noch einmal eine Anpassung für die Textgröße notwendig.
   procedure SchriftpositionFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin
      
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
      Rechenwert.y := Float (AktuelleAuflösung.y / 100);
      
      if
        Rechenwert.y < 20.00
      then
         Rechenwert.y := 20.00;
         
      else
         null;
      end if;
      
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (WelchesMenüExtern, Überschrift));
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (WelchesMenüExtern, Überschrift),
                                    position => Rechenwert);
      
      Rechenwert.y := Rechenwert.y + 3.00 * Sf.Graphics.Text.getLocalBounds (text => TextAccess (WelchesMenüExtern, Überschrift)).height + ZeilenAbstand;
      
      PositionenSchleife:
      for PositionSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop
         
         case
           PositionSchleifenwert mod 2
         is
            when 0 =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
                                                                                            LinksRechtsExtern => True);
               
            when others =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
                                                                                            LinksRechtsExtern => False);
         end case;
         
         Sf.Graphics.Text.setPosition (text     => TextAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
                                       position => Rechenwert);
         
         case
           PositionSchleifenwert mod 2
         is
            when 0 =>
               -- Ist das nicht immer der Abstant zur Überschrift? Mal anpassen.
               Rechenwert.y := Rechenwert.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess (WelchesMenüExtern, Überschrift)).height + ZeilenAbstand;
               
            when others =>
               null;
         end case;
         
         InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert));
         
      end loop PositionenSchleife;
      
      Rechenwert.y := Float (AktuelleAuflösung.y) - Sf.Graphics.Text.getLocalBounds (text => TextAccess (WelchesMenüExtern, TextbereichExtern)).height - Float (AktuelleAuflösung.y / 100);
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (WelchesMenüExtern, TextbereichExtern));
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (WelchesMenüExtern, TextbereichExtern),
                                    position => Rechenwert);
      
   end SchriftpositionFestlegen;
   
   
   
   procedure SchriftartZurücksetzen
   is begin
      
      SchriftartFestgelegt := (others => LeerSchriftartFestgelegt);
      AuflösungBerechnet := (others => LeerAuflösungBerechnet);
      
   end SchriftartZurücksetzen;
   
   
   
   procedure TextZurücksetzen
   is begin
      
      TextFestgelegt := (others => False);
      AuflösungBerechnet := (others => LeerAuflösungBerechnet);
      
   end TextZurücksetzen;
   
   
   
   procedure SchriftgrößeZurücksetzen
   is begin
      
      SchriftgrößeFestgelegt := (others => LeerSchriftgrößeFestgelegt);
      AuflösungBerechnet := (others => LeerAuflösungBerechnet);
      
   end SchriftgrößeZurücksetzen;

end AuswahlMenuesEinfachSFML;

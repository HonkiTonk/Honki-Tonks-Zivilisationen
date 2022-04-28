pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
with Sf.Graphics.Color; use Sf.Graphics.Color;
with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with RassenDatentypen; use RassenDatentypen;
with MenueDatentypen; use MenueDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SonstigesKonstanten;
with SpielVariablen;
with SpielDatentypen;
with SonstigeVariablen;

with GrafikEinstellungenSFML;
with AllgemeineTextBerechnungenSFML;
with AuswahlMenuesStringsSetzen;
with AuswahlMenuesEinfach;
with AuswahlMenuesZusatztextSFML;
with Karten;
with MenueHintergrundSFML;

package body AuswahlMenuesEinfachSFML is

   procedure AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum)
   is begin
      
      MenueHintergrundSFML.MenüHintergrund (WelchesMenüExtern  => WelchesMenüExtern,
                                            SpriteAccessExtern => SpriteAccess);
      
      Textbereich := Überschrift + SystemKonstanten.EndeMenü (WelchesMenüExtern) - SystemKonstanten.EndeAbzugGrafik (WelchesMenüExtern) + Versionsnummer;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Ohne_Überschrift_Enum'Range =>
            HauptmenüAbzug := 1;
            SchleifenAbzug := 0;
            
         when others =>
            HauptmenüAbzug := 0;
            SchleifenAbzug := 1;
      end case;
      
      AktuelleAuswahlRückgabewert := Textbearbeitung (WelchesMenüExtern => WelchesMenüExtern,
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
         when MenueDatentypen.Menü_Zusatztext_Einfach_Enum'Range =>
            AuswahlMenuesZusatztextSFML.MenüsZusatztextAufteilung (WelchesMenüExtern     => WelchesMenüExtern,
                                                                    AktuelleAuswahlExtern => AktuelleAuswahlRückgabewert);
            
         when others =>
            null;
      end case;
      
   end AuswahlMenüsEinfach;
   
   
   
   function Textbearbeitung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
      return Natural
   is begin
      
      AktuelleAuflösung := GrafikEinstellungenSFML.AktuelleFensterAuflösung;
      AktuelleSchriftgröße := GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße;
      AktuelleSchriftfarben := GrafikEinstellungenSFML.Schriftfarben;

      case
        SchriftartFestgelegt
      is
         when False =>
            SchriftartFestgelegt := SchriftartFestlegen;
            
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
      
      ------------------- Bessere Lösung für die Zurücksetzung der ausgewählten Menüoption einbauen, als alles zurückzusetzen?
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
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Einstellung_Anzeigen_Enum'Range =>
            FarbeAktuelleEinstellungenFestlegen (WelchesMenüExtern => WelchesMenüExtern);
            
         when others =>
            null;
      end case;
      
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
      
      return AktuelleAuswahl;
      
   end Textbearbeitung;
   
   
   
   function SchriftartFestlegen
     return Boolean
   is begin
      
      MenüSchleife:
      for MenüSchleifenwert in TextAccessArray'Range (1) loop
         TextSchleife:
         for TextSchleifenwert in TextAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextAccess (MenüSchleifenwert, TextSchleifenwert),
                                      font => GrafikEinstellungenSFML.SchriftartAccess);
            
         end loop TextSchleife;
      end loop MenüSchleife;
            
      return True;
      
   end SchriftartFestlegen;



   procedure SchriftgrößenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
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
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
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
   
   
   
   procedure FarbeAktuelleEinstellungenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einstellung_Anzeigen_Enum)
   is begin
      
      -- Das + 1 kommt daher dass die Enums in Ada immer bei 0 anfangen.
      AktuelleEinstellung := Überschrift + 1;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Kartengröße_Menü_Enum =>
            AktuelleEinstellung := AktuelleEinstellung + KartenDatentypen.Kartengröße_Enum'Pos (Karten.Kartenparameter.Kartengröße);
            
         when MenueDatentypen.Kartenart_Menü_Enum =>
            AktuelleEinstellung := AktuelleEinstellung + KartenDatentypen.Kartenart_Enum'Pos (Karten.Kartenparameter.Kartenart);
            
         when MenueDatentypen.Kartentemperatur_Menü_Enum =>
            AktuelleEinstellung := AktuelleEinstellung + KartenDatentypen.Kartentemperatur_Enum'Pos (Karten.Kartenparameter.Kartentemperatur);
            
         when MenueDatentypen.Kartenressourcen_Menü_Enum =>
            AktuelleEinstellung := AktuelleEinstellung + KartenDatentypen.Kartenressourcen_Enum'Pos (Karten.Kartenparameter.Kartenressourcen);
            
         when MenueDatentypen.Schwierigkeitsgrad_Menü_Enum =>
            AktuelleEinstellung := AktuelleEinstellung + SpielDatentypen.Schwierigkeitsgrad_Enum'Pos (SpielVariablen.Schwierigkeitsgrad);
            
         when MenueDatentypen.Rassen_Menü_Enum =>
            -- Hier geht die einfache Auswahl nicht, weil ja mehrere Dinge unterschiedlich ausgewählt sein können.
            FarbeAusgewählteRassenFestlegen;
            return;
      end case;
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop
         
         if
           Sf.Graphics.Text.getColor (text => TextAccess (WelchesMenüExtern, Überschrift + SchriftfarbeSchleifenwert)) = GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText
         then
            Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, Überschrift + SchriftfarbeSchleifenwert),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
            exit SchriftfarbeSchleife;
            
         else
            null;
         end if;
                  
      end loop SchriftfarbeSchleife;
      
      if
        Sf.Graphics.Text.getColor (text => TextAccess (WelchesMenüExtern, AktuelleEinstellung)) = GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText
      then
         null;
                                   
      else
         Sf.Graphics.Text.setColor (text  => TextAccess (WelchesMenüExtern, AktuelleEinstellung),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText);
      end if;
      
   end FarbeAktuelleEinstellungenFestlegen;
   
   
   
   procedure FarbeAusgewählteRassenFestlegen
   is begin
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (MenueDatentypen.Rassen_Menü_Enum) - SchleifenAbzug loop
         
         Farbe := Sf.Graphics.Text.getColor (text => TextAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + SchriftfarbeSchleifenwert));
         
         if
           Farbe = GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText
           or
             Farbe = GrafikEinstellungenSFML.Schriftfarben.FarbeKIText
         then
            Sf.Graphics.Text.setColor (text  => TextAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + SchriftfarbeSchleifenwert),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
            
         else
            null;
         end if;
                  
      end loop SchriftfarbeSchleife;
      
      FarbenFestlegenSchleife:
      for FarbenFestlegenSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (MenueDatentypen.Rassen_Menü_Enum) - SchleifenAbzug loop
         
         if
           Sf.Graphics.Text.getColor (text => TextAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + FarbenFestlegenSchleifenwert)) = GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText
         then
            null;
            
         elsif
           RassenDatentypen.Rassen_Verwendet_Enum'Pos (RassenDatentypen.Rassen_Verwendet_Enum'Last) < FarbenFestlegenSchleifenwert
         then
            exit FarbenFestlegenSchleife;
            
         elsif
           SonstigeVariablen.RassenImSpiel (RassenDatentypen.Rassen_Verwendet_Enum'Val (FarbenFestlegenSchleifenwert)) = RassenDatentypen.Spieler_Mensch_Enum
         then
            Sf.Graphics.Text.setColor (text  => TextAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + FarbenFestlegenSchleifenwert),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText);
            
         elsif
           SonstigeVariablen.RassenImSpiel (RassenDatentypen.Rassen_Verwendet_Enum'Val (FarbenFestlegenSchleifenwert)) = RassenDatentypen.Spieler_KI_Enum
         then
            Sf.Graphics.Text.setColor (text  => TextAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + FarbenFestlegenSchleifenwert),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeKIText);
            
         else
            null;
         end if;
         
      end loop FarbenFestlegenSchleife;
      
   end FarbeAusgewählteRassenFestlegen;
   
   
   
   procedure FarbeAktuelleAuswahlFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
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
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Ohne_Überschrift_Enum'Range =>
            Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, Überschrift),
                                               str  => SonstigesKonstanten.Spielename);
            
         when MenueDatentypen.Menü_Mit_Überschrift_Enum'Range | MenueDatentypen.Menü_Zusatztext_Einfach_Enum'Range =>
            Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, Überschrift),
                                               str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => Überschrift,
                                                                                                            WelchesMenüExtern => WelchesMenüExtern));
      end case;
      
      TextSchleife:
      for TextSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop
                  
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, Überschrift + TextSchleifenwert),
                                            str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => Überschrift + TextSchleifenwert - HauptmenüAbzug,
                                                                                                         WelchesMenüExtern => WelchesMenüExtern));
         
      end loop TextSchleife;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (WelchesMenüExtern, TextbereichExtern),
                                         str  => "Version: " & SonstigesKonstanten.Versionsnummer);
      
   end TextFestlegen;
   
   
   
   ------------------------- Später noch die Berechnung für verschiedene Auflösungen einbauen, so dass die Texte immer reinpassen.
   ------------------------- Dafür ist vermutlich auch noch einmal eine Anpassung für die Textgröße notwendig.
   procedure SchriftpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
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
         
         ----------------------- Mal mein FalseTrue System nachprüfen.
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
         
         InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert));
         
      end loop PositionenSchleife;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Kartengröße_Menü_Enum =>
            InteraktionAuswahl.LetzteTextpositionKartengröße := Rechenwert.y;
            
         when others =>
            null;
      end case;
      
      --------------------- Scheint noch nicht hoch genug zu sein.
      Rechenwert.y := Float (AktuelleAuflösung.y) - Sf.Graphics.Text.getLocalBounds (text => TextAccess (WelchesMenüExtern, TextbereichExtern)).height - Float (AktuelleAuflösung.y / 100);
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (WelchesMenüExtern, TextbereichExtern));
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (WelchesMenüExtern, TextbereichExtern),
                                    position => Rechenwert);
      
   end SchriftpositionFestlegen;
   
   
   
   procedure SchriftartZurücksetzen
   is begin
      
      SchriftartFestgelegt := False;
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
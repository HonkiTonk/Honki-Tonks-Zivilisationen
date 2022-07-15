pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
with Sf.Graphics.Color; use Sf.Graphics.Color;
with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with RassenDatentypen; use RassenDatentypen;
with MenueDatentypen; use MenueDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SonstigesKonstanten;
with SpielVariablen;
with SpielDatentypen;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with AuswahlMenuesStringsSetzen;
with AuswahlMenuesEinfach;
with AuswahlMenuesZusatztextSFML;
with HintergrundSFML;
with InteraktionAuswahl;
with KartengeneratorVariablen;

package body AuswahlMenuesEinfachSFML is

   procedure AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum)
   is begin
      
      HintergrundSFML.MenüHintergrund (WelchesMenüExtern  => WelchesMenüExtern,
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
                                            text         => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextSchleifenwert));
         
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
      AktuelleSchriftgröße := GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard;
      AktuelleSchriftfarben := GrafikEinstellungenSFML.Schriftfarben;
      
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



   procedure SchriftgrößenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin

      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern),
                                         size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeKlein);

   end SchriftgrößenFestlegen;



   procedure SchriftfarbenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern),
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
            -- Hier wird keine Farbfestlegung benötigt, da es inzwischen eine Zahlenanzeige dafür gibt.
            return;
            
         when MenueDatentypen.Kartenart_Menü_Enum =>
            AktuelleEinstellung := AktuelleEinstellung + KartenDatentypen.Kartenart_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenart);
            
         when MenueDatentypen.Kartentemperatur_Menü_Enum =>
            AktuelleEinstellung := AktuelleEinstellung + KartenDatentypen.Kartentemperatur_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartentemperatur);
            
         when MenueDatentypen.Kartenressourcen_Menü_Enum =>
            AktuelleEinstellung := AktuelleEinstellung + KartenDatentypen.Kartenressourcen_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenressourcen);
            
         when MenueDatentypen.Schwierigkeitsgrad_Menü_Enum =>
            AktuelleEinstellung := AktuelleEinstellung + SpielDatentypen.Schwierigkeitsgrad_Enum'Pos (SpielVariablen.Allgemeines.Schwierigkeitsgrad);
            
         when MenueDatentypen.Rassen_Menü_Enum =>
            -- Hier geht die einfache Auswahl nicht, weil ja mehrere Dinge unterschiedlich ausgewählt sein können.
            FarbeAusgewählteRassenFestlegen;
            return;
      end case;
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop
         
         if
           Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + SchriftfarbeSchleifenwert)) = GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText
         then
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + SchriftfarbeSchleifenwert),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
            exit SchriftfarbeSchleife;
            
         else
            null;
         end if;
                  
      end loop SchriftfarbeSchleife;
      
      if
        Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, AktuelleEinstellung)) = GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText
      then
         null;
                                   
      else
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, AktuelleEinstellung),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText);
      end if;
      
   end FarbeAktuelleEinstellungenFestlegen;
   
   
   
   procedure FarbeAusgewählteRassenFestlegen
   is begin
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (MenueDatentypen.Rassen_Menü_Enum) - SchleifenAbzug loop
         
         Farbe := Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + SchriftfarbeSchleifenwert));
         
         if
           Farbe = GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText
           or
             Farbe = GrafikEinstellungenSFML.Schriftfarben.FarbeKIText
         then
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + SchriftfarbeSchleifenwert),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
            
         else
            null;
         end if;
                  
      end loop SchriftfarbeSchleife;
      
      FarbenFestlegenSchleife:
      for FarbenFestlegenSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (MenueDatentypen.Rassen_Menü_Enum) - SchleifenAbzug loop
         
         if
           Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess
                                      (MenueDatentypen.Rassen_Menü_Enum, Überschrift + FarbenFestlegenSchleifenwert)) = GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText
         then
            null;
            
         elsif
           RassenDatentypen.Rassen_Verwendet_Enum'Pos (RassenDatentypen.Rassen_Verwendet_Enum'Last) < FarbenFestlegenSchleifenwert
         then
            exit FarbenFestlegenSchleife;
            
         elsif
           SpielVariablen.RassenImSpiel (RassenDatentypen.Rassen_Verwendet_Enum'Val (FarbenFestlegenSchleifenwert)) = RassenDatentypen.Mensch_Spieler_Enum
         then
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + FarbenFestlegenSchleifenwert),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText);
            
         elsif
           SpielVariablen.RassenImSpiel (RassenDatentypen.Rassen_Verwendet_Enum'Val (FarbenFestlegenSchleifenwert)) = RassenDatentypen.KI_Spieler_Enum
         then
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + FarbenFestlegenSchleifenwert),
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
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, LetzteAuswahlExtern + Überschrift),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
      end case;
      
      case
        AktuelleAuswahlExtern
      is
         when SystemKonstanten.LeerAuswahl =>
            null;
            
         when others =>
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, AktuelleAuswahlExtern + Überschrift),
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
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift),
                                               str  => SonstigesKonstanten.Spielname);
            
         when MenueDatentypen.Menü_Mit_Überschrift_Enum'Range | MenueDatentypen.Menü_Zusatztext_Einfach_Enum'Range =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift),
                                               str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => Überschrift,
                                                                                                            WelchesMenüExtern => WelchesMenüExtern));
      end case;
      
      TextSchleife:
      for TextSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop
                  
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + TextSchleifenwert),
                                            str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => Überschrift + TextSchleifenwert - HauptmenüAbzug,
                                                                                                         WelchesMenüExtern => WelchesMenüExtern));
         
      end loop TextSchleife;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern),
                                         str  => "Version: " & SonstigesKonstanten.Versionsnummer);
      
   end TextFestlegen;
   
   
   
   ------------------------- Später noch die Berechnung für verschiedene Auflösungen einbauen, so dass die Texte immer reinpassen.
   ------------------------- Dafür ist vermutlich auch noch einmal eine Anpassung für die Textgröße notwendig.
   procedure SchriftpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin
      
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
      Rechenwert.y := Float (AktuelleAuflösung.y / 100);
      
      if
        Rechenwert.y < 20.00
      then
         Rechenwert.y := 20.00;
         
      else
         null;
      end if;
      
      Rechenwert.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift),
                                    position => Rechenwert);
      
      Rechenwert.y := Rechenwert.y + 3.00 * Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift)).height + ZeilenAbstand;
      
      PositionenSchleife:
      for PositionSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop
         
         case
           PositionSchleifenwert mod 2
         is
            when 0 =>
               Rechenwert.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
                                                                                            LinksRechtsExtern => False);
               
            when others =>
               Rechenwert.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
                                                                                            LinksRechtsExtern => True);
         end case;
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
                                       position => Rechenwert);
         
         case
           PositionSchleifenwert mod 2
         is
            when 0 =>
               -- Ist das nicht immer der Abstant zur Überschrift? Mal anpassen.
               Rechenwert.y := Rechenwert.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift)).height + ZeilenAbstand;
               
            when others =>
               null;
         end case;
         
         InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert)
           := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert));
         
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
      Rechenwert.y := Float (AktuelleAuflösung.y) - Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern)).height - Float (AktuelleAuflösung.y / 100);
      Rechenwert.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern),
                                    position => Rechenwert);
      
   end SchriftpositionFestlegen;

end AuswahlMenuesEinfachSFML;

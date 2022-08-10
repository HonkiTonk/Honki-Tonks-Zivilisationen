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
with SystemKonstanten;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with AuswahlMenuesStringsSetzen;
with AuswahlMenuesEinfach;
with AuswahlMenuesZusatztextSFML;
with InteraktionAuswahl;
with KartengeneratorVariablen;
with TextberechnungenHoeheSFML;
with TexteinstellungenSFML;
with ViewsEinstellenSFML;

package body AuswahlMenuesEinfachSFML is

   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
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
                                                       TextbereichExtern => Textbereich,
                                                       ViewflächeExtern  => ViewflächeExtern);
      
      TextSchleife:
      for TextSchleifenwert in Überschrift .. Textbereich loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextSchleifenwert));
         
      end loop TextSchleife;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Zusatztext_Einfach_Enum'Range =>
            AuswahlMenuesZusatztextSFML.MenüsZusatztextAufteilung (WelchesMenüExtern     => WelchesMenüExtern,
                                                                    AktuelleAuswahlExtern => AktuelleAuswahlRückgabewert.Auswahl);
            
         when others =>
            null;
      end case;
      
      return ViewsEinstellenSFML.ViewflächeAuflösungAnpassen (ViewflächeExtern => AktuelleAuswahlRückgabewert.Textposition);
      
   end AuswahlMenüsEinfach;
   
   
   
   function Textbearbeitung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return GrafikRecords.AuswahlTextpositionRecord
   is begin
      
      SchriftgrößenFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                                TextbereichExtern => TextbereichExtern);
      
      TextFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                     TextbereichExtern => TextbereichExtern);
      
      SchriftfarbenFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                              TextbereichExtern => TextbereichExtern);
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Einstellung_Anzeigen_Enum'Range =>
            FarbeAktuelleEinstellungenFestlegen (WelchesMenüExtern => WelchesMenüExtern);
            
         when others =>
            null;
      end case;
      
      -- Auch über die Taskdateien regeln lassen und niemals die Dateien direkt aufrufen, überall so einbauen. äöü
      -- AktuelleAuswahl := AuswahlMenuesEinfach.AktuelleAuswahl;
      Rückgabewert.Auswahl := AuswahlMenuesEinfach.AktuelleAuswahl;
      
      FarbeAktuelleAuswahlFestlegen (WelchesMenüExtern     => WelchesMenüExtern,
                                     AktuelleAuswahlExtern => Rückgabewert.Auswahl);
      
      Rückgabewert.Textposition := TextpositionFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                                                           TextbereichExtern => TextbereichExtern,
                                                           ViewflächeExtern  => ViewflächeExtern);
      
      return Rückgabewert;
      
   end Textbearbeitung;



   procedure SchriftgrößenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin

      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift),
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern),
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeKlein);

   end SchriftgrößenFestlegen;



   procedure SchriftfarbenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      TextfarbeSchleife:
      for TextfarbeSchleifenwert in Überschrift + 1 .. TextbereichExtern - 1 loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextfarbeSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop TextfarbeSchleife;
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern),
                                 color => TexteinstellungenSFML.Schriftfarben.FarbeSonstigerText);

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
           Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + SchriftfarbeSchleifenwert)) = TexteinstellungenSFML.Schriftfarben.FarbeMenschText
         then
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + SchriftfarbeSchleifenwert),
                                       color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
            exit SchriftfarbeSchleife;
            
         else
            null;
         end if;
                  
      end loop SchriftfarbeSchleife;
      
      if
        Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, AktuelleEinstellung)) = TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText
      then
         null;
                                   
      else
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, AktuelleEinstellung),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeMenschText);
      end if;
      
   end FarbeAktuelleEinstellungenFestlegen;
   
   
   
   procedure FarbeAusgewählteRassenFestlegen
   is begin
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (MenueDatentypen.Rassen_Menü_Enum) - SchleifenAbzug loop
         
         Farbe := Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + SchriftfarbeSchleifenwert));
         
         if
           Farbe = TexteinstellungenSFML.Schriftfarben.FarbeMenschText
           or
             Farbe = TexteinstellungenSFML.Schriftfarben.FarbeKIText
         then
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + SchriftfarbeSchleifenwert),
                                       color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
            
         else
            null;
         end if;
                  
      end loop SchriftfarbeSchleife;
      
      FarbenFestlegenSchleife:
      for FarbenFestlegenSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (MenueDatentypen.Rassen_Menü_Enum) - SchleifenAbzug loop
         
         if
           Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + FarbenFestlegenSchleifenwert))
             = TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText
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
                                       color => TexteinstellungenSFML.Schriftfarben.FarbeMenschText);
            
         elsif
           SpielVariablen.RassenImSpiel (RassenDatentypen.Rassen_Verwendet_Enum'Val (FarbenFestlegenSchleifenwert)) = RassenDatentypen.KI_Spieler_Enum
         then
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + FarbenFestlegenSchleifenwert),
                                       color => TexteinstellungenSFML.Schriftfarben.FarbeKIText);
            
         else
            null;
         end if;
         
      end loop FarbenFestlegenSchleife;
      
   end FarbeAusgewählteRassenFestlegen;
   
   
   
   procedure FarbeAktuelleAuswahlFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural)
   is begin
      
      case
        AktuelleAuswahlExtern
      is
         when SystemKonstanten.LeerAuswahl =>
            null;
            
         when others =>
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, AktuelleAuswahlExtern + Überschrift),
                                       color => TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
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
   
   
   
   function TextpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin

      Rechenwert.y := StartpositionText.y;
      Rechenwert.x := StartpositionText.x + ViewflächeExtern.x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift));

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift),
                                    position => Rechenwert);

      AktuelleTextbreite := StartpositionText.x + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift)).width + StartpositionText.x;
      Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.Überschriftabstand;

      PositionenSchleife:
      for PositionSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop

         Rechenwert.x := StartpositionText.x + ViewflächeExtern.x / 2.00
           - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert)) + StartpositionText.x;
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
                                       position => Rechenwert);

         NeueTextbreite := StartpositionText.x + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert)).width + StartpositionText.x;
         
         InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert)
           := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert));

         if
           NeueTextbreite > AktuelleTextbreite
         then
            AktuelleTextbreite := NeueTextbreite;

         else
            null;
         end if;

         Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
      end loop PositionenSchleife;

      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Kartengröße_Menü_Enum =>
            InteraktionAuswahl.LetzteTextpositionKartengröße := Rechenwert.y;

         when others =>
            null;
      end case;

      if
        ViewflächeExtern.y > Rechenwert.y
      then
         PositionVersionsnummer := ViewflächeExtern.y - 3.00 * StartpositionText.y - Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern)).height;

      else
         PositionVersionsnummer := Rechenwert.y;
      end if;

      Rechenwert.x := StartpositionText.x
        + ViewflächeExtern.x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern)) + StartpositionText.x;

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern),
                                    position => (Rechenwert.x, PositionVersionsnummer));
      Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;

      NeueTextbreite := StartpositionText.x + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern)).width + StartpositionText.x;

      if
        NeueTextbreite > AktuelleTextbreite
      then
         AktuelleTextbreite := NeueTextbreite;

      else
         null;
      end if;

      return (AktuelleTextbreite, Rechenwert.y);

   end TextpositionFestlegen;

end AuswahlMenuesEinfachSFML;

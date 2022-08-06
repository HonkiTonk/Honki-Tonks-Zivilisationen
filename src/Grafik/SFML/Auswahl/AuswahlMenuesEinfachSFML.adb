pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
with Sf.Graphics.Color; use Sf.Graphics.Color;
with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;
with Sf.Graphics.View;

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
with ViewsSFML;

package body AuswahlMenuesEinfachSFML is

   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum)
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
                                                       TextbereichExtern  => Textbereich);
      
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
      
      return AktuelleAuswahlRückgabewert.Textposition;
      
   end AuswahlMenüsEinfach;
   
   
   
   function Textbearbeitung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
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
                                                              TextbereichExtern => TextbereichExtern);
      
      return Rückgabewert;
      
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
      
      TextfarbeSchleife:
      for TextfarbeSchleifenwert in Überschrift + 1 .. TextbereichExtern - 1 loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextfarbeSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop TextfarbeSchleife;
      
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
           Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, Überschrift + FarbenFestlegenSchleifenwert))
             = GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText
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
      AktuelleAuswahlExtern : in Natural)
   is begin
      
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
   
   
   
   function TextpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Rechenwert.y := StartpositionText.y;
      -- Den View später mit übergeben, wenn es denn so funktioniert wie ich mir das vorstelle.
      Rechenwert.x := StartpositionText.x + Sf.Graphics.View.getSize (view => ViewsSFML.MenüviewAccess).x / 2.00
        - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift));
      -- Rechenwert.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift),
                                    position => Rechenwert);
      
      AktuelleTextbreite := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift)).left
        + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift)).width + StartpositionText.x;
      Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.Überschriftabstand;
      
      PositionenSchleife:
      for PositionSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop
         
         case
           PositionSchleifenwert mod 2
         is
            when 0 =>
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
                                             position => Rechenwert);
               -- Rechenwert.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
               --                                                                      LinksRechtsExtern => False);
               NeueTextbreite := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert)).left
                 + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert)).width + StartpositionText.x;
               
            when others =>
               -- if
               --   PositionSchleifenwert = SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug
               -- then
               -- Hier eine Prüfung bauen um den Text in der Mitte zu platzieren?
               Rechenwert.x := StartpositionText.x;
         
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
                                             position => Rechenwert);
               
               Rechenwert.x := Rechenwert.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert)).width + 20.00;
               -- Rechenwert.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
               --                                                                      LinksRechtsExtern => True);
               NeueTextbreite := StartpositionText.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert)).width;
         end case;
         
         case
           PositionSchleifenwert mod 2
         is
            when 0 =>
               Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
            when others =>
               null;
         end case;
         
         InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert)
           := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert));
         
         if
           NeueTextbreite > AktuelleTextbreite
         then
            AktuelleTextbreite := NeueTextbreite;
            
         else
            null;
         end if;
         
      end loop PositionenSchleife;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Kartengröße_Menü_Enum =>
            InteraktionAuswahl.LetzteTextpositionKartengröße := Rechenwert.y;
            
         when others =>
            null;
      end case;
      
      Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.ÜberschriftabstandGroß;
      Rechenwert.x := StartpositionText.x + Sf.Graphics.View.getSize (view => ViewsSFML.MenüviewAccess).x / 2.00
        - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern));
      -- Rechenwert.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern),
                                    position => Rechenwert);
      Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      return (AktuelleTextbreite, Rechenwert.y);
      
   end TextpositionFestlegen;

end AuswahlMenuesEinfachSFML;

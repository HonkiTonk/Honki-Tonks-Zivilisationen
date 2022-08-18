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
with TextaccessVariablen;
with SystemKonstanten;
with TextKonstanten;
with InteraktionAuswahl;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with AuswahlMenuesStringsSetzen;
with AuswahlMenuesZusatztextSFML;
with KartengeneratorVariablen;
with TextberechnungenHoeheSFML;
with TexteinstellungenSFML;
with AllgemeineTextanzeigeSFML;
with NachGrafiktask;

package body AuswahlMenuesEinfachSFML is

   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Ende := SystemKonstanten.EndeAbzugGrafik (WelchesMenüExtern);
            
      AktuelleAuswahlRückgabewert := Textbearbeitung (WelchesMenüExtern => WelchesMenüExtern,
                                                       TextbereichExtern => Ende,
                                                       ViewflächeExtern  => ViewflächeExtern);
      
      AllgemeineTextanzeigeSFML.Überschrift;
      
      TextSchleife:
      for TextSchleifenwert in StartpunktTextschleifen .. Ende loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextSchleifenwert));
         
      end loop TextSchleife;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Zusatztext_Einfach_Enum'Range =>
            AktuelleAuswahlRückgabewert.Textposition := AuswahlMenuesZusatztextSFML.MenüsZusatztextAufteilung (WelchesMenüExtern     => WelchesMenüExtern,
                                                                                                               AktuelleAuswahlExtern => AktuelleAuswahlRückgabewert.Auswahl,
                                                                                                               ViewflächeExtern      => ViewflächeExtern,
                                                                                                               TextpositionExtern    => AktuelleAuswahlRückgabewert.Textposition);
            
         when others =>
            null;
      end case;
      
      AktuelleAuswahlRückgabewert.Textposition := AllgemeineTextanzeigeSFML.Versionsnummer (ViewflächeExtern           => ViewflächeExtern,
                                                                                             AktuelleTextpositionExtern => AktuelleAuswahlRückgabewert.Textposition);
            
      return AktuelleAuswahlRückgabewert.Textposition;
      
   end AuswahlMenüsEinfach;
   
   
   
   -- TextbereichEnde später mal in TextendeExtern oder sowas umbenennen. äöü
   function Textbearbeitung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return GrafikRecords.AuswahlTextpositionRecord
   is begin
      
      SchriftfarbenFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                              TextbereichExtern => TextbereichExtern);
      
      TextFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                     TextbereichExtern => TextbereichExtern);
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Einstellung_Anzeigen_Enum'Range =>
            FarbeAktuelleEinstellungenFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                                                 TextbereichExtern => TextbereichExtern);
            
         when others =>
            null;
      end case;
      
      Rückgabewert.Auswahl := NachGrafiktask.AktuelleAuswahl;
      
      FarbeAktuelleAuswahlFestlegen (WelchesMenüExtern     => WelchesMenüExtern,
                                     AktuelleAuswahlExtern => Rückgabewert.Auswahl);
      
      Rückgabewert.Textposition := TextpositionFestlegen (WelchesMenüExtern => WelchesMenüExtern,
                                                           TextbereichExtern => TextbereichExtern,
                                                           ViewflächeExtern  => ViewflächeExtern);
      
      return Rückgabewert;
      
   end Textbearbeitung;



   procedure SchriftfarbenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
   is begin
            
      TextfarbeSchleife:
      for TextfarbeSchleifenwert in StartpunktTextschleifen .. TextbereichExtern loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextfarbeSchleifenwert),
                                    color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop TextfarbeSchleife;
      
   end SchriftfarbenFestlegen;
   
   
   
   -- Hier noch TextbereichExtern einbauen und TextbereichExtern mal in Ende/EndeExtern umbenennen. äöü
   procedure FarbeAktuelleEinstellungenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einstellung_Anzeigen_Enum;
      TextbereichExtern : in Positive)
   is begin
      
      -- Das kommt daher dass die Enums in Ada immer bei 0 anfangen.
      AktuelleEinstellung := 2;
      
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
            FarbeAusgewählteRassenFestlegen (TextbereichExtern => TextbereichExtern);
            return;
      end case;
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in StartpunktTextschleifen .. TextbereichExtern loop
         
         if
           Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, SchriftfarbeSchleifenwert)) = TexteinstellungenSFML.Schriftfarben.FarbeMenschText
         then
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, SchriftfarbeSchleifenwert),
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
     (TextbereichExtern : in Positive)
   is begin
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in StartpunktTextschleifen .. TextbereichExtern loop
         
         Farbe := Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, SchriftfarbeSchleifenwert));
         
         if
           Farbe = TexteinstellungenSFML.Schriftfarben.FarbeMenschText
           or
             Farbe = TexteinstellungenSFML.Schriftfarben.FarbeKIText
         then
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, SchriftfarbeSchleifenwert),
                                       color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
            
         else
            null;
         end if;
                  
      end loop SchriftfarbeSchleife;
      
      FarbenFestlegenSchleife:
      for FarbenFestlegenSchleifenwert in StartpunktTextschleifen .. TextbereichExtern loop
         
         if
           Sf.Graphics.Text.getColor (text => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, FarbenFestlegenSchleifenwert)) = TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText
         then
            null;
            
         elsif
           RassenDatentypen.Rassen_Verwendet_Enum'Pos (RassenDatentypen.Rassen_Verwendet_Enum'Last) < FarbenFestlegenSchleifenwert - 1
         then
            exit FarbenFestlegenSchleife;
            
         elsif
           SpielVariablen.RassenImSpiel (RassenDatentypen.Rassen_Verwendet_Enum'Val (FarbenFestlegenSchleifenwert - 1)) = RassenDatentypen.Mensch_Spieler_Enum
         then
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, FarbenFestlegenSchleifenwert),
                                       color => TexteinstellungenSFML.Schriftfarben.FarbeMenschText);
            
         elsif
           SpielVariablen.RassenImSpiel (RassenDatentypen.Rassen_Verwendet_Enum'Val (FarbenFestlegenSchleifenwert - 1)) = RassenDatentypen.KI_Spieler_Enum
         then
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (MenueDatentypen.Rassen_Menü_Enum, FarbenFestlegenSchleifenwert),
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
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, AktuelleAuswahlExtern + 1),
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
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                               str  => SonstigesKonstanten.Spielname);
            
         when MenueDatentypen.Menü_Mit_Überschrift_Enum'Range | MenueDatentypen.Menü_Zusatztext_Einfach_Enum'Range =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                               str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 1,
                                                                                                            WelchesMenüExtern => WelchesMenüExtern));
      end case;
      
      TextSchleife:
      for TextSchleifenwert in StartpunktTextschleifen .. TextbereichExtern loop
                  
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextSchleifenwert),
                                            str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => TextSchleifenwert,
                                                                                                         WelchesMenüExtern => WelchesMenüExtern));
         
      end loop TextSchleife;
      
   end TextFestlegen;
   
   
   
   function TextpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Rechenwert.y := TextKonstanten.StartpositionText.y;
      Rechenwert.x := ViewflächeExtern.x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess);

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ÜberschriftAccess,
                                    position => Rechenwert);

      AktuelleTextbreite := TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ÜberschriftAccess).width;
      Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.Überschriftabstand;

      PositionenSchleife:
      for PositionSchleifenwert in StartpunktTextschleifen .. TextbereichExtern loop

         case
           WelchesMenüExtern
         is
            when MenueDatentypen.Rassen_Menü_Enum =>
               Rechenwert.x := TextKonstanten.StartpositionText.x;
               
            when others =>
               Rechenwert.x := ViewflächeExtern.x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, PositionSchleifenwert));
         end case;
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, PositionSchleifenwert),
                                       position => Rechenwert);

         NeueTextbreite := TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, PositionSchleifenwert)).width;
         
         InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert - 1)
           := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, PositionSchleifenwert));
         
         -- Das mal Rausschieben? äöü
         if
           NeueTextbreite > AktuelleTextbreite
         then
            AktuelleTextbreite := NeueTextbreite;

         else
            null;
         end if;

         Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
      end loop PositionenSchleife;

      return (AktuelleTextbreite, Rechenwert.y);

   end TextpositionFestlegen;

end AuswahlMenuesEinfachSFML;

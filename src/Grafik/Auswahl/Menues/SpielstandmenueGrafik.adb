with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with Views;
with GrafikDatentypen;
with TextaccessVariablen;
with MenueKonstanten;
with InteraktionAuswahl;
with MenueDatentypen;
with TextKonstanten;
with VerzeichnisKonstanten;
with GrafikKonstanten;
with ViewKonstanten;
with TextDatentypen;

with LeseGrafiktask;

with HintergrundGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextfarbeGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with TextskalierungGrafik;
with SpielstandVariablen;
with TexteinstellungenGrafik;
with SpielstandlisteLogik;

package body SpielstandmenueGrafik is

   procedure Spielstandmenü
     (AuswahlExtern : in SystemRecords.MehrfachauswahlRecord)
   is begin
      
      ViewflächeAufteilung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeAufteilung,
                                                                                  VerhältnisExtern => (GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandKategorie).width,
                                                                                                        GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandKategorie).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SpielstandviewAccesse (ViewKonstanten.SpielstandKategorie),
                                            GrößeExtern          => ViewflächeAufteilung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandKategorie));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeAufteilung);
                  
      ViewflächeAufteilung := Spielstandaufteilung (AuswahlExtern       => AuswahlExtern.Zweitauswahl,
                                                     SpielstandartExtern => SpielstandlisteLogik.Spielstandart);
            
      
      
      ViewflächeBelegung := ViewsEinstellenGrafik.ViewflächeXFestYVariabel (ViewflächeExtern => ViewflächeBelegung,
                                                                              VerhältnisExtern => (GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandAuswahl).width,
                                                                                                    GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandAuswahl).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SpielstandviewAccesse (ViewKonstanten.SpielstandAuswahl),
                                            GrößeExtern          => ViewflächeBelegung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandAuswahl));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeBelegung);
      
      ViewflächeBelegung := Textanzeige (ViewflächeExtern => ViewflächeBelegung,
                                          AuswahlExtern    => AuswahlExtern.Erstauswahl);
      
   end Spielstandmenü;
   
   
   
   function Spielstandaufteilung
     (AuswahlExtern : in Integer;
      SpielstandartExtern : in SpielstandDatentypen.Spielstand_Enum)
      return Sf.System.Vector2.sfVector2f
   is
      use type SpielstandDatentypen.Spielstand_Enum;
   begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.Spaltenabstand;
      
      AufteilungSchleife:
      for AufteilungSchleifenwert in InteraktionAuswahl.PositionenSpielstandaufteilung'Range loop
         
         if
           AuswahlExtern = -AufteilungSchleifenwert
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Ausgewählt_Enum);
         
         elsif
           SpielstandartExtern = SpielstandDatentypen.Manueller_Spielstand_Enum
           and
             AufteilungSchleifenwert = 1
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Aktiver_Menübereich_Enum);
            
         elsif
           SpielstandartExtern = SpielstandDatentypen.Automatischer_Spielstand_Enum
           and
             AufteilungSchleifenwert = 2
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Aktiver_Menübereich_Enum);
           
         else
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
         end if;
         
         TextaccessverwaltungssystemEinfachGrafik.PositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.SpielstandAccess (AufteilungSchleifenwert + 1),
                                                                         PositionExtern   => Textposition,
                                                                         FarbeExtern      => Farbe);
         
         InteraktionAuswahl.PositionenSpielstandaufteilung (AufteilungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SpielstandAccess (AufteilungSchleifenwert + 1));
      
         Textposition.x := Textposition.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.SpielstandAccess (AufteilungSchleifenwert + 1)).width
           + GrafikKonstanten.Verdoppelung * TextberechnungenBreiteGrafik.Spaltenabstand;
         
      end loop AufteilungSchleife;
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
      return (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
   end Spielstandaufteilung;
   
   
   
   function Textanzeige
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      NeueTextbreite := GrafikKonstanten.Nullwert;
      
      MehrereSeiten := LeseGrafiktask.Seitenauswahl;
      SpeichernLaden := LeseGrafiktask.SpeichernLaden;
      Spielstand := SpielstandVariablen.GanzeSpielstandliste;
      
      TextSchleife:
      for TextSchleifenwert in MenueKonstanten.SpielstandAnfang .. MenueKonstanten.EndeAbzugGrafik (MenueDatentypen.Spielstand_Menü_Enum) loop
         
         if
           SpeichernLaden = False
           and
             TextSchleifenwert = NeuerSpielstand
         then
            null;
            
         elsif
           TextSchleifenwert = MehrAnzeigen
           and
             MehrereSeiten = False
         then
            null;
            
         else
            case
              TextSchleifenwert
            is
               when SpielstandlisteAnfang .. SpielstandlisteEnde =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                     str  => TextSetzen (TextExtern => To_Wide_Wide_String (Spielstand (TextSchleifenwert - MenueKonstanten.SchleifenanpassungGrafikLogik - 2))));
                  
               when others =>
                  null;
            end case;
            
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnenGlobaleGrenzen (TextAccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                                                  ViewbreiteExtern => ViewflächeExtern.x);
            
            if
              TextSchleifenwert = MenueKonstanten.EndeAbzugGrafik (MenueDatentypen.Spielstand_Menü_Enum) - MenueKonstanten.SchleifenanpassungGrafikLogik
              and
                LeseGrafiktask.Löschauswahl
            then
               Farbe := Sf.Graphics.Color.sfRed;
               
            else
               Farbe := TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => TextSchleifenwert - MenueKonstanten.SchleifenanpassungGrafikLogik,
                                                               AuswahlExtern    => AuswahlExtern);
            end if;
         
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                                TextbreiteExtern => GrafikKonstanten.Nullwert);
            Skalierung.x := TextskalierungGrafik.Verkleinerung (AktuelleBreiteExtern => Textbreite,
                                                                ErlaubteBreiteExtern => ViewflächeExtern.x);
            Skalierung.y := GrafikRecordKonstanten.Standardskalierung.y;
            
            NeueTextbreite := Textbreite;
            
            TextaccessverwaltungssystemEinfachGrafik.PositionSkalierenFarbeZeichnen (TextaccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                                     PositionExtern   => Textposition,
                                                                                     SkalierungExtern => Skalierung,
                                                                                     FarbeExtern      => Farbe);
            
            InteraktionAuswahl.PositionenSpielstand (TextSchleifenwert - MenueKonstanten.SchleifenanpassungGrafikLogik)
              := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SpielstandAccess (TextSchleifenwert));
         end if;
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
         
      end loop TextSchleife;
      
      return (NeueTextbreite, Textposition.y);
      
   end Textanzeige;
   
   
   
   function TextSetzen
     (TextExtern : in Wide_Wide_String)
      return Wide_Wide_String
   is begin
      
      if
        TextExtern = TextKonstanten.LeerString
      then
         return TextExtern;
         
      elsif
        Exists (Name => VerzeichnisKonstanten.SpielstandStrich & Encode (Item => TextExtern)) = False
      then
         return TextExtern;
         
      else
         return (TextExtern & TextKonstanten.StandardAbstand & Decode (Item => Local_Image (Date                  => Modification_Time (Name => (VerzeichnisKonstanten.SpielstandStrich & Encode (Item => TextExtern))),
                                                                                            Include_Time_Fraction => False)));
      end if;
      
   end TextSetzen;

end SpielstandmenueGrafik;

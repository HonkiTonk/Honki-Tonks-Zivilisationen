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

with LeseGrafiktask;

with HintergrundGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextfarbeGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with TextskalierungGrafik;
with SpielstandVariablen;

package body SpielstandmenueGrafik is

   procedure Spielstandmenü
     (AuswahlExtern : in Integer)
   is begin
      
      ViewflächeAufteilung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeAufteilung,
                                                                                  VerhältnisExtern => (GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandKategorie).width,
                                                                                                        GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandKategorie).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (ViewKonstanten.SpielstandKategorie),
                                            GrößeExtern          => ViewflächeAufteilung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandKategorie));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeAufteilung);
                  
      ViewflächeAufteilung := Spielstandaufteilung (AuswahlExtern => AuswahlExtern);
      
      
      
      
      
      ViewflächeBelegung := ViewsEinstellenGrafik.ViewflächeXFestYVariabel (ViewflächeExtern => ViewflächeBelegung,
                                                                              VerhältnisExtern => (GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandAuswahl).width,
                                                                                                    GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandAuswahl).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (ViewKonstanten.SpielstandAuswahl),
                                            GrößeExtern          => ViewflächeBelegung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandAuswahl));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeBelegung);
      
      
      
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.MenüEinfachbereich.width, GrafikRecordKonstanten.MenüEinfachbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccesse (ViewKonstanten.MenüAuswahl),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.MenüEinfachbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Viewfläche := Textanzeige (ViewflächeExtern => Viewfläche,
                                  AuswahlExtern    => AuswahlExtern);
      
   end Spielstandmenü;
   
   
   
   function Spielstandaufteilung
     (AuswahlExtern : in Integer)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.Spaltenabstand;
      
      case
        AuswahlExtern
      is
         when 0 =>
            null;
         
         when others =>
            null;
      end case;
      
      return (0.00, 0.00);
      
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
      for TextSchleifenwert in MenueKonstanten.StandardArrayanpassung .. MenueKonstanten.EndeAbzugGrafik (MenueDatentypen.Spielstand_Menü_Enum) loop
         
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
                                                     str  => TextSetzen (TextExtern => To_Wide_Wide_String (Spielstand (TextSchleifenwert - MenueKonstanten.SchleifenanpassungGrafikLogik))));
                  
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

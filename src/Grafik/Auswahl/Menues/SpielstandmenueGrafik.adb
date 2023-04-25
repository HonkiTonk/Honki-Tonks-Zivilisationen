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

with HintergrundGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with NachGrafiktask;
with TextfarbeGrafik;
with TextaccessverwaltungssystemGrafik;
with TextskalierungGrafik;

package body SpielstandmenueGrafik is

   procedure Spielstandmenü
     (AuswahlExtern : in Natural)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.MenüEinfachbereich.width, GrafikRecordKonstanten.MenüEinfachbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.MenüEinfachbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Viewfläche := Textanzeige (ViewflächeExtern => Viewfläche,
                                  AuswahlExtern    => AuswahlExtern);
      
   end Spielstandmenü;
   
   
   
   function Textanzeige
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      NeueTextbreite := GrafikKonstanten.Nullwert;
      
      MehrereSeiten := NachGrafiktask.MehrereSeiten;
      SpeichernLaden := NachGrafiktask.SpeichernLaden;
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
                                                     str  => TextSetzen (TextExtern => To_Wide_Wide_String (Spielstand (TextSchleifenwert - MenueKonstanten.SchleifenwertanpassungGrafikZuAuswahlPosition))));
                  
               when others =>
                  null;
            end case;
            
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnenGlobaleGrenzen (TextAccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                                                  ViewbreiteExtern => ViewflächeExtern.x);
            
            if
              TextSchleifenwert = MenueKonstanten.EndeAbzugGrafik (MenueDatentypen.Spielstand_Menü_Enum) - 1
              and
                NachGrafiktask.LöschenAusgewählt
            then
               Farbe := Sf.Graphics.Color.sfRed;
               
            else
               Farbe := TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => TextSchleifenwert - MenueKonstanten.SchleifenwertanpassungGrafikZuAuswahlPosition,
                                                               AuswahlExtern    => AuswahlExtern);
            end if;
         
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                                TextbreiteExtern => GrafikKonstanten.Nullwert);
            Skalierung.x := TextskalierungGrafik.Breitenskalierung (AktuelleBreiteExtern => Textbreite,
                                                                    ErlaubteBreiteExtern => ViewflächeExtern.x);
            Skalierung.y := GrafikRecordKonstanten.Standardskalierung.y;
            
            NeueTextbreite := Textbreite;
            
            TextaccessverwaltungssystemGrafik.PositionSkalierenFarbeZeichnen (TextaccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                              PositionExtern   => Textposition,
                                                                              SkalierungExtern => Skalierung,
                                                                              FarbeExtern      => Farbe);
            
            InteraktionAuswahl.PositionenSpielstand (TextSchleifenwert - MenueKonstanten.SchleifenwertanpassungGrafikZuAuswahlPosition)
              := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SpielstandAccess (TextSchleifenwert));
         end if;
         
         Textposition.y := TextberechnungenHoeheGrafik.KonstanteTextposition (PositionExtern   => Textposition.y,
                                                                              ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
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

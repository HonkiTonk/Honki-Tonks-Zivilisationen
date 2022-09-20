pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Views;
with GrafikDatentypen;
with TextaccessVariablen;
with SystemKonstanten;
with InteraktionAuswahl;
with MenueDatentypen;
with TextKonstanten;
with VerzeichnisKonstanten;

with HintergrundGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with NachGrafiktask;
with EinstellungenGrafik;
with TextfarbeGrafik;

package body SpielstandmenueGrafik is

   procedure Spielstandmenü
     (AuswahlExtern : in Natural)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
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
      Textbreite := 0.00;
      
      MehrereSeiten := NachGrafiktask.MehrereSeiten;
      SpeichernLaden := NachGrafiktask.SpeichernLaden;
      Spielstand := SpielstandlisteLogik.Spielstand;
      
      TextSchleife:
      for TextSchleifenwert in SystemKonstanten.StandardArrayanpassung .. SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Spielstand_Menü_Enum) loop
         
         if
           SpeichernLaden = False
           and
             TextSchleifenwert = 13
         then
            null;
            
         elsif
           TextSchleifenwert = 12
           and
             MehrereSeiten = False
         then
            null;
            
         else
            case
              TextSchleifenwert
            is
               when 2 .. 11 =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                     str  => TextSetzen (TextExtern => To_Wide_Wide_String (Spielstand (TextSchleifenwert - 1))));
                  
               when others =>
                  null;
            end case;
         
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                                    ViewbreiteExtern => ViewflächeExtern.x);
         
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                          position => Textposition);
         
            TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => TextSchleifenwert - 1,
                                                   AuswahlExtern    => AuswahlExtern,
                                                   TextaccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert));
         
            InteraktionAuswahl.PositionenSpielstand (TextSchleifenwert - 1) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SpielstandAccess (TextSchleifenwert));
         
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                                TextbreiteExtern => Textbreite);
         
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.SpielstandAccess (TextSchleifenwert));
         end if;
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop TextSchleife;
      
      return (Textbreite, Textposition.y);
      
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
         return (TextExtern & TextKonstanten.LangerAbstand & Decode (Item => Local_Image (Date                  => Modification_Time (Name => (VerzeichnisKonstanten.SpielstandStrich & Encode (Item => TextExtern))),
                                                                                          Include_Time_Fraction => True)));
      end if;
      
   end TextSetzen;

end SpielstandmenueGrafik;

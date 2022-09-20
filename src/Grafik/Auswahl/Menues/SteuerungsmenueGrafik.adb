pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard; use Sf.Window.Keyboard;
with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Views;
with GrafikDatentypen;
with SystemKonstanten;
with TextaccessVariablen;
with InteraktionAuswahl;
with MenueDatentypen;
with TastenbelegungDatentypen;
with TextKonstanten;
with TastenbelegungKonstanten;
with Meldungstexte;
with TextnummernKonstanten;
with TastenbelegungVariablen;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with EinstellungenGrafik;
with TextfarbeGrafik;

package body SteuerungsmenueGrafik is

   procedure Steuerungsmenü
     (AuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord)
   is begin
      
      ViewflächeText := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeText,
                                                                            VerhältnisExtern => (0.33, 0.50));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (1),
                                            GrößeExtern          => ViewflächeText,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (1));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeText);
                  
      ViewflächeText := BefehleAnzeigen (AuswahlExtern => AuswahlExtern);
      
      ViewflächeText.y := ViewflächeText.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      
      ViewflächeBelegung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeBelegung,
                                                                                VerhältnisExtern => (0.33, 0.50));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (2),
                                            GrößeExtern          => ViewflächeBelegung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (2));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeBelegung);
      
      ViewflächeBelegung := BelegungAnzeigen (AuswahlExtern => AuswahlExtern.AuswahlZwei);
      
      ViewflächeBelegung.y := ViewflächeBelegung.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
   end Steuerungsmenü;
   
   
   
   function BefehleAnzeigen
     (AuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textbreite := 0.00;
      Zusatzabstand := True;

      PositionenSchleife:
      for PositionSchleifenwert in SystemKonstanten.StandardArrayanpassung .. SystemKonstanten.EndeMenü (MenueDatentypen.Steuerung_Menü_Enum) loop

         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         if
           PositionSchleifenwert <= SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Steuerung_Menü_Enum)
         then
            TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => PositionSchleifenwert,
                                                   AuswahlExtern    => AuswahlExtern.AuswahlZwei + SystemKonstanten.StandardArrayanpassung
                                                   - TastenbelegungDatentypen.Tastenbelegung_Auswählbar_Enum'Pos (TastenbelegungDatentypen.Tastenbelegung_Auswählbar_Enum'First),
                                                   TextaccessExtern => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert));
               
         else
            TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => PositionSchleifenwert,
                                                   AuswahlExtern    => AuswahlExtern.AuswahlEins,
                                                   TextaccessExtern => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert));
            
            InteraktionAuswahl.PositionenSteuerung (PositionSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert));
            
            case
              Zusatzabstand
            is
               when True =>
                  Zusatzabstand := False;
                  Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
                  
               when False =>
                  null;
            end case;
         end if;
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert),
                                       position => Textposition);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert));
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y);
      
   end BefehleAnzeigen;
   
   
   
   function BelegungAnzeigen
     (AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textbreite := 0.00;
      
      PositionenSchleife:
      for PositionSchleifenwert in TastenbelegungDatentypen.Tastenbelegung_Auswählbar_Enum'Range loop
         
         AktuelleBelegung := TastenbelegungVariablen.Tastenbelegung (PositionSchleifenwert);
         
         case
           AktuelleBelegung
         is
            when Sf.Window.Keyboard.sfKeyUnknown =>
               Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugLeer);
               
            when Sf.Window.Keyboard.sfKeyA .. Sf.Window.Keyboard.sfKeyCount =>
               Text := TastenbelegungKonstanten.Tastennamen (AktuelleBelegung);
               
            when others =>
               Text := TextKonstanten.LeerUnboundedString & Wide_Wide_Character'Val (191);
         end case;
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                            str  => To_Wide_Wide_String (Source => Text));
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                       position => Textposition);
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                             TextbreiteExtern => Textbreite);
         
         TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => TastenbelegungDatentypen.Tastenbelegung_Enum'Pos (PositionSchleifenwert),
                                                AuswahlExtern    => AuswahlExtern,
                                                TextaccessExtern => TextaccessVariablen.TextAccess);
         
         InteraktionAuswahl.PositionenSteuerungbelegung (PositionSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.TextAccess);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.TextAccess);
         
      end loop PositionenSchleife;
      
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      ZusatzSchleife:
      for ZusatzSchleifenwert in SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Steuerung_Menü_Enum) + 1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Steuerung_Menü_Enum) loop
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (ZusatzSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
         
      end loop ZusatzSchleife;
      
      return (Textbreite, Textposition.y);
      
   end BelegungAnzeigen;

end SteuerungsmenueGrafik;

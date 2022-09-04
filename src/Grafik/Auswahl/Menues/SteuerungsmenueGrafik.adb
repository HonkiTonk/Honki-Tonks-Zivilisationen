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
with TexteinstellungenGrafik;

package body SteuerungsmenueGrafik is

   procedure Steuerungsmenü
     (AuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord)
   is begin
      
      ViewflächeText := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeText,
                                                                          VerhältnisExtern => (0.33, 1.00));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (1),
                                          GrößeExtern          => ViewflächeText,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (1));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                        AbmessungenExtern => ViewflächeText);
                  
      ViewflächeText := BefehleAnzeigen (AuswahlExtern => AuswahlExtern.AuswahlEins);
      
      ViewflächeText.y := ViewflächeText.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      
      ViewflächeText := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeText,
                                                                          VerhältnisExtern => (0.10, 0.70));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (2),
                                          GrößeExtern          => ViewflächeText,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (2));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                        AbmessungenExtern => ViewflächeText);
      
      BelegungAnzeigen (AuswahlExtern => AuswahlExtern.AuswahlZwei);
      
   end Steuerungsmenü;
   
   
   
   function BefehleAnzeigen
     (AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := 0.00;
      Textposition.x := TextKonstanten.StartpositionText.x;
      Textbreite := 0.00;
      Zusatzabstand := True;

      PositionenSchleife:
      for PositionSchleifenwert in Textarrayanpassung .. SystemKonstanten.EndeMenü (MenueDatentypen.Steuerung_Menü_Enum) loop

         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert),
                                                                           TextbreiteExtern => Textbreite);
         
         if
           PositionSchleifenwert <= SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Steuerung_Menü_Enum)
         then
            null;
               
         else
            FarbeFestlegen (AuswahlExtern    => AuswahlExtern,
                            TextnummerExtern => PositionSchleifenwert,
                            TextaccessExtern => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert));
         
            InteraktionAuswahl.PositionenSteuerung (PositionSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert));
            
            case
              Zusatzabstand
            is
               when True =>
                  Zusatzabstand := False;
                  Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand;
                  
               when False =>
                  null;
            end case;
         end if;
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert),
                                       position => Textposition);
         
         Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand;
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert));
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y);
      
   end BefehleAnzeigen;
   
   
   
   procedure BelegungAnzeigen
     (AuswahlExtern : in Natural)
   is begin
      
      Textposition.y := 0.00;
      Textposition.x := TextKonstanten.StartpositionText.x;
      
      PositionenSchleife:
      for PositionSchleifenwert in TastenbelegungDatentypen.Tastenbelegung_Auswählbar_Enum'Range loop
         
         -- Das mal mit der Ermittlung der neuen Taste in EingabeLogik zusammenführen. äöü
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
         
         FarbeFestlegen (AuswahlExtern    => AuswahlExtern,
                         TextnummerExtern => TastenbelegungDatentypen.Tastenbelegung_Enum'Pos (PositionSchleifenwert),
                         TextaccessExtern => TextaccessVariablen.TextAccess);
         
         InteraktionAuswahl.PositionenSteuerungbelegung (PositionSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.TextAccess);
         
         Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand;
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.TextAccess);
         
      end loop PositionenSchleife;
      
   end BelegungAnzeigen;
   
   
   
   procedure FarbeFestlegen
     (AuswahlExtern : in Natural;
      TextnummerExtern : in Positive;
      TextaccessExtern : in Sf.Graphics.sfText_Ptr)
   is begin
      
      if
        AuswahlExtern = TextnummerExtern
      then
         Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
            
      else
         Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeStandardText;
      end if;
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => Farbe);
      
   end FarbeFestlegen;

end SteuerungsmenueGrafik;

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
with TextnummernKonstanten;
with GlobaleTexte;

with ViewsEinstellenSFML;
with HintergrundSFML;
with TextberechnungenHoeheSFML;
with TextberechnungenBreiteSFML;
with GrafikEinstellungenSFML;
with TexteinstellungenSFML;
with EingabeSFML;

package body AuswahlMenueSteuerungSFML is

   procedure AuswahlMenüSteuerung
     (AuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord)
   is begin
      
      ViewflächeText := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeText,
                                                                          VerhältnisExtern => (0.33, 1.00));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (1),
                                          GrößeExtern          => ViewflächeText,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (1));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => ViewflächeText);
                  
      ViewflächeText := BefehleAnzeigen (AuswahlExtern => AuswahlExtern.AuswahlEins);
      
      ViewflächeText.y := ViewflächeText.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (2),
                                          GrößeExtern          => ViewflächeText,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (2));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                        AbmessungenExtern => ViewflächeText);
      
      BelegungAnzeigen (AuswahlExtern => AuswahlExtern.AuswahlZwei);
      
   end AuswahlMenüSteuerung;
   
   
   
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

         Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert),
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
                  Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
                  
               when False =>
                  null;
            end case;
         end if;
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert),
                                       position => Textposition);
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.SteuerungSFMLAccess (PositionSchleifenwert));
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y);
      
   end BefehleAnzeigen;
   
   
   
   procedure BelegungAnzeigen
     (AuswahlExtern : in Natural)
   is begin
      
      Textposition.y := 0.00;
      Textposition.x := TextKonstanten.StartpositionText.x;
      Textbreite := 0.00;
      
      PositionenSchleife:
      for PositionSchleifenwert in TastenbelegungDatentypen.Tastenbelegung_Auswählbar_Enum'Range loop
         
         AktuelleBelegung := EingabeSFML.Tastenbelegung (PositionSchleifenwert);
         
         case
           AktuelleBelegung
         is
            when Sf.Window.Keyboard.sfKeyUnknown =>
               Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugLeer);
               
            when Sf.Window.Keyboard.sfKeyA .. Sf.Window.Keyboard.sfKeyZ =>
               Text := TextKonstanten.LeerUnboundedString & Wide_Wide_Character'Val (AktuelleBelegung + 65);
               
            when Sf.Window.Keyboard.sfKeyNum0 .. Sf.Window.Keyboard.sfKeyNum9 =>
               Text := TextKonstanten.LeerUnboundedString & Wide_Wide_Character'Val (AktuelleBelegung + 22);
               
            when Sf.Window.Keyboard.sfKeySpace =>
               Text := TextKonstanten.LeerUnboundedString & "Space";
               
            when others =>
               Text := TextKonstanten.LeerUnboundedString & Wide_Wide_Character'Val (191);
         end case;
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                            str  => To_Wide_Wide_String (Source => Text));
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                       position => Textposition);

         Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                           TextbreiteExtern => Textbreite);
         
         FarbeFestlegen (AuswahlExtern    => AuswahlExtern,
                         TextnummerExtern => TastenbelegungDatentypen.Tastenbelegung_Enum'Pos (PositionSchleifenwert),
                         TextaccessExtern => TextaccessVariablen.TextAccess);
         
         InteraktionAuswahl.PositionenSteuerungbelegung (PositionSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.TextAccess);
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
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
         Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
            
      else
         Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
      end if;
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => Farbe);
      
   end FarbeFestlegen;

end AuswahlMenueSteuerungSFML;

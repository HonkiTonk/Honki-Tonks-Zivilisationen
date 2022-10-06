pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with Sf.Window.Keyboard; use Sf.Window.Keyboard;
with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Views;
with GrafikDatentypen;
with SystemKonstanten;
with TextaccessVariablen;
with InteraktionAuswahl;
-- with MenueDatentypen;
with TastenbelegungDatentypen;
with TextKonstanten;
with TastenbelegungKonstanten;
with Meldungstexte;
with TextnummernKonstanten;
with TastenbelegungVariablen;
with Menuetexte;
with BefehleDatentypen;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with EinstellungenGrafik;
with TextfarbeGrafik;
with TexteinstellungenGrafik;
with SteuerungsauswahlLogik;

package body SteuerungsmenueGrafik is

   procedure Steuerungsmenü
     (AuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord)
   is begin
      
      ViewflächeAufteilung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeAufteilung,
                                                                                  VerhältnisExtern => (GrafikRecordKonstanten.Steuerungbereich (1).width, GrafikRecordKonstanten.Steuerungbereich (1).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (1),
                                            GrößeExtern          => ViewflächeAufteilung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (1));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeAufteilung);
                  
      ViewflächeAufteilung := Steuerungsaufteilung (AuswahlExtern         => AuswahlExtern,
                                                     WelcheSteuerungExtern => SteuerungsauswahlLogik.WelcheSteuerung);
      
      
            
      ViewflächeBelegung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeBelegung,
                                                                                VerhältnisExtern => (GrafikRecordKonstanten.Steuerungbereich (2).width, GrafikRecordKonstanten.Steuerungbereich (2).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (2),
                                            GrößeExtern          => ViewflächeBelegung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (2));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeBelegung);
      
      ViewflächeBelegung := Steuerung (AuswahlExtern         => AuswahlExtern.AuswahlEins,
                                        WelcheSteuerungExtern => SteuerungsauswahlLogik.WelcheSteuerung);
      
   end Steuerungsmenü;
   
   
   
   function Steuerungsaufteilung
     (AuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord;
      WelcheSteuerungExtern : in Boolean)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.SpaltenabstandVariabel;
      Textbreite := 0.00;
      
      if
        AuswahlExtern.AuswahlEins = -1
      then
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.AllgemeineSteuerung),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText);
         
      elsif
        WelcheSteuerungExtern = False
      then
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.AllgemeineSteuerung),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeMenschText);
           
      else
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.AllgemeineSteuerung),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      end if;
         
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.AllgemeineSteuerung),
                                    position => Textposition);
      
      InteraktionAuswahl.PositionenSteuerungsaufteilung (1) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.AllgemeineSteuerung));
      
      Textposition.x := Textposition.x + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.AllgemeineSteuerung)).width
        + 2.00 * TextberechnungenBreiteGrafik.SpaltenabstandVariabel;
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.AllgemeineSteuerung));
      
      if
        AuswahlExtern.AuswahlZwei = -1
      then
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Einheitensteuerung),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText);
         
      elsif
        WelcheSteuerungExtern
      then
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Einheitensteuerung),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeMenschText);
           
      else
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Einheitensteuerung),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      end if;
         
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Einheitensteuerung),
                                    position => Textposition);
      
      InteraktionAuswahl.PositionenSteuerungsaufteilung (2) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Einheitensteuerung));
      
      Textposition.x := Textposition.x + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Einheitensteuerung)).width
        + TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Einheitensteuerung),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Einheitensteuerung));
      
      return (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Steuerungsaufteilung;
   
   
   
   function Steuerung
     (AuswahlExtern : in Integer;
      WelcheSteuerungExtern : in Boolean)
      return Sf.System.Vector2.sfVector2f
   is begin
            
      case
        WelcheSteuerungExtern
      is
         when False =>
            ArrayAnfang := SystemKonstanten.AllgemeineSteuerung + 1;
            ArrayEnde := SystemKonstanten.Einheitensteuerung - 1;
            
         when True =>
            ArrayAnfang := SystemKonstanten.Einheitensteuerung + 1;
            ArrayEnde := SystemKonstanten.SonstigesSteuerung - 1;
      end case;
      
      Textposition.x := TextberechnungenBreiteGrafik.SpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      Textbreite := 0.00;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.SteuerungSFMLAccess'Range loop
         
         if
           TextSchleifenwert in ArrayAnfang .. ArrayEnde
           or
             TextSchleifenwert >= SystemKonstanten.SonstigesSteuerung
         then
            TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => TextSchleifenwert,
                                                   AuswahlExtern    => AuswahlExtern,
                                                   TextaccessExtern => TextaccessVariablen.SteuerungSFMLAccess (TextSchleifenwert));
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SteuerungSFMLAccess (TextSchleifenwert),
                                          position => Textposition);
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SteuerungSFMLAccess (TextSchleifenwert),
                                               str  => TextFestlegen (WelcheSteuerungExtern => WelcheSteuerungExtern,
                                                                      WelcheZeileExtern     => TextSchleifenwert));
            
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (TextSchleifenwert),
                                                                                TextbreiteExtern => Textbreite);
            
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (TextSchleifenwert),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.SteuerungSFMLAccess (TextSchleifenwert));
            
            InteraktionAuswahl.PositionenSteuerung (TextSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungSFMLAccess (TextSchleifenwert));
            
         elsif
           TextSchleifenwert = SystemKonstanten.Einheitensteuerung
         then
            null;
            
         else
            InteraktionAuswahl.PositionenSteuerung (TextSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
         end if;
         
      end loop TextSchleife;
      
      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
   end Steuerung;
   
   
   
   function TextFestlegen
     (WelcheSteuerungExtern : in Boolean;
      WelcheZeileExtern : in Positive)
      return Wide_Wide_String
   is begin
      
      if
        WelcheZeileExtern >= SystemKonstanten.SonstigesSteuerung
      then
         return To_Wide_Wide_String (Source => Menuetexte.Steuerungmenü (WelcheZeileExtern));
           
      else
         Text := Menuetexte.Steuerungmenü (WelcheZeileExtern) & TextKonstanten.LangerAbstand;
      end if;
                                               
      case
        WelcheSteuerungExtern
      is
         when False =>
            AktuelleBelegung := TastenbelegungVariablen.AllgemeineBelegung (TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum'Val (WelcheZeileExtern - SystemKonstanten.AllgemeineSteuerungEnumausgleich));
            
         when True =>
            AktuelleBelegung := TastenbelegungVariablen.Einheitenbelegung (BefehleDatentypen.Einheiten_Bewegung_Enum'Val (WelcheZeileExtern - SystemKonstanten.EinheitensteuerungEnumausgleich));
      end case;
      
      case
        AktuelleBelegung
      is
         when Sf.Window.Keyboard.sfKeyUnknown =>
            Text := Text & Meldungstexte.Zeug (TextnummernKonstanten.ZeugLeer);

         when Sf.Window.Keyboard.sfKeyA .. Sf.Window.Keyboard.sfKeyCount =>
            Text := Text & TastenbelegungKonstanten.Tastennamen (AktuelleBelegung);

         when others =>
            Text := Text & Wide_Wide_Character'Val (191);
      end case;
      
      return To_Wide_Wide_String (Source => Text);
      
   end TextFestlegen;

end SteuerungsmenueGrafik;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Views;
with GrafikDatentypen;
with SystemKonstanten;
with TextaccessVariablen;
with InteraktionAuswahl;
with TastenbelegungDatentypen;
with TextKonstanten;
with TastenbelegungKonstanten;
with Meldungstexte;
with TextnummernKonstanten;
with TastenbelegungVariablen;
with Menuetexte;
with BefehleDatentypen;

with SteuerungsauswahlLogik; use SteuerungsauswahlLogik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with EinstellungenGrafik;
with TextfarbeGrafik;
with TexteinstellungenGrafik;

package body SteuerungsmenueGrafik is

   procedure Steuerungsmenü
     (AuswahlExtern : in Integer)
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
      
      ViewflächeBelegung := Steuerung (AuswahlExtern         => AuswahlExtern,
                                        WelcheSteuerungExtern => SteuerungsauswahlLogik.WelcheSteuerung);
      
   end Steuerungsmenü;
   
   
   
   -- Das hier später noch in einer Schleife zusammenfassen. äöü
   function Steuerungsaufteilung
     (AuswahlExtern : in Integer;
      WelcheSteuerungExtern : in SteuerungsauswahlLogik.Kategorie_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.SpaltenabstandVariabel;
      Textbreite := 0.00;
      
      if
        AuswahlExtern = -1
      then
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.AllgemeineSteuerung),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText);
         
      elsif
        WelcheSteuerungExtern = SteuerungsauswahlLogik.Kategorie_Eins_Enum
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
        AuswahlExtern = -2
      then
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Einheitensteuerung),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText);
         
      elsif
        WelcheSteuerungExtern = SteuerungsauswahlLogik.Kategorie_Zwei_Enum
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
        + 2.00 * TextberechnungenBreiteGrafik.SpaltenabstandVariabel;
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Einheitensteuerung));
      
      if
        AuswahlExtern = -3
      then
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Stadtsteuerung),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText);
         
      elsif
        WelcheSteuerungExtern = SteuerungsauswahlLogik.Kategorie_Drei_Enum
      then
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Stadtsteuerung),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeMenschText);
         
      else
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Stadtsteuerung),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      end if;
         
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Stadtsteuerung),
                                    position => Textposition);
      
      InteraktionAuswahl.PositionenSteuerungsaufteilung (3) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Stadtsteuerung));
      
      Textposition.x := Textposition.x + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Stadtsteuerung)).width
        + 2.00 * TextberechnungenBreiteGrafik.SpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Stadtsteuerung),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.SteuerungSFMLAccess (SystemKonstanten.Stadtsteuerung));
      
      return (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Steuerungsaufteilung;
   
   
   
   function Steuerung
     (AuswahlExtern : in Integer;
      WelcheSteuerungExtern : in SteuerungsauswahlLogik.Kategorie_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
            
      case
        WelcheSteuerungExtern
      is
         when SteuerungsauswahlLogik.Kategorie_Eins_Enum =>
            ArrayAnfang := SystemKonstanten.AllgemeineSteuerung + 1;
            ArrayEnde := SystemKonstanten.Einheitensteuerung - 1;
            
         when SteuerungsauswahlLogik.Kategorie_Zwei_Enum =>
            ArrayAnfang := SystemKonstanten.Einheitensteuerung + 1;
            ArrayEnde := SystemKonstanten.Stadtsteuerung - 1;
            
         when SteuerungsauswahlLogik.Kategorie_Drei_Enum =>
            ArrayAnfang := SystemKonstanten.Stadtsteuerung + 1;
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
     (WelcheSteuerungExtern : in SteuerungsauswahlLogik.Kategorie_Enum;
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
         when SteuerungsauswahlLogik.Kategorie_Eins_Enum =>
            AktuelleBelegung := TastenbelegungVariablen.AllgemeineBelegung (TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum'Val (WelcheZeileExtern - SystemKonstanten.AllgemeineSteuerungEnumausgleich));
            
         when SteuerungsauswahlLogik.Kategorie_Zwei_Enum =>
            AktuelleBelegung := TastenbelegungVariablen.Einheitenbelegung (BefehleDatentypen.Einheiten_Bewegung_Enum'Val (WelcheZeileExtern - SystemKonstanten.EinheitensteuerungEnumausgleich));
            
         when SteuerungsauswahlLogik.Kategorie_Drei_Enum =>
            AktuelleBelegung := TastenbelegungVariablen.Stadtbelegung (BefehleDatentypen.Stadtbefehle_Vorhanden_Enum'Val (WelcheZeileExtern - SystemKonstanten.StadtsteuerungEnumausgleich));
      end case;
      
      case
        AktuelleBelegung
      is
         when Sf.Window.Keyboard.sfKeyUnknown =>
            Text := Text & Meldungstexte.Zeug (TextnummernKonstanten.ZeugLeer);

         when TastenbelegungKonstanten.TastennamenArray'Range =>
            Text := Text & TastenbelegungKonstanten.Tastennamen (AktuelleBelegung);

         when others =>
            Text := Text & Wide_Wide_Character'Val (191);
      end case;
      
      return To_Wide_Wide_String (Source => Text);
      
   end TextFestlegen;

end SteuerungsmenueGrafik;

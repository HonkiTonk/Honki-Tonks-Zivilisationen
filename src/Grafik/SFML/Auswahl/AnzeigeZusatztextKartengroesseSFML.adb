pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with SystemKonstanten;
with MenueDatentypen;
with KartenKonstanten;

with GrafikEinstellungenSFML;
with AuswahlMenuesStringsSetzen;
with Karten;
with AllgemeineTextBerechnungenSFML;
with InteraktionAuswahl;
with TextaccessVariablen;

package body AnzeigeZusatztextKartengroesseSFML is

   procedure AnzeigeZusatztextKartengröße
     (AktuelleAuswahlExtern : in Natural)
   is begin
      
      Textbearbeitung (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ZusatztextKartengrößeAccess (1));
      
      case
        AktuelleAuswahlExtern
      is
         when 0 =>
            null;
            
         when others =>
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.ZusatztextKartengrößeAccess (2));
      end case;
        
   end AnzeigeZusatztextKartengröße;
   
   
   
   procedure Textbearbeitung
     (AktuelleAuswahlExtern : in Natural)
   is begin
      
      TextFestlegen (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      PositionFestlegen;
      
   end Textbearbeitung;
   
   
   
   procedure TextFestlegen
     (AktuelleAuswahlExtern : in Natural)
   is begin
    
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                         str  =>
                                           AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => SystemKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum) - 1,
                                                                                                WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum) & "    " & "5x"
                                         & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv (ZahlExtern => Karten.Kartenparameter.Kartengröße.YAchse)) & "x"
                                         & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv (ZahlExtern => Karten.Kartenparameter.Kartengröße.XAchse)));
      
      case
        AktuelleAuswahlExtern
      is
         when 0 =>
            null;
            
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                               str  =>
                                                  AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => SystemKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum),
                                                                                                       WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum) & "    " & "5x"
                                               & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv
                                                                      (ZahlExtern => KartenKonstanten.StandardKartengrößen (StandardKartengrößen (AktuelleAuswahlExtern)).YAchse))
                                               & "x"
                                               & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv
                                                                      (ZahlExtern => KartenKonstanten.StandardKartengrößen (StandardKartengrößen (AktuelleAuswahlExtern)).XAchse)));
      end case;
      
   end TextFestlegen;
   
   
   
   procedure PositionFestlegen
   is begin
      
      PositionText.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (1));
      PositionText.y := InteraktionAuswahl.LetzteTextpositionKartengröße + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.ZusatztextKartengrößeAccess (1)).height;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                    position => PositionText);
      
      PositionText.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (2));
      PositionText.y := PositionText.y + 2.00 * Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.ZusatztextKartengrößeAccess (2)).height;
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                    position => PositionText);
      
   end PositionFestlegen;

end AnzeigeZusatztextKartengroesseSFML;

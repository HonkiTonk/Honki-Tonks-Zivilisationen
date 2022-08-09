pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with SystemKonstanten;
with MenueDatentypen;
with KartenKonstanten;
with TextKonstanten;

with GrafikEinstellungenSFML;
with AuswahlMenuesStringsSetzen;
with KartengeneratorVariablen;
with TextberechnungenBreiteSFML;
with InteraktionAuswahl;
with TextaccessVariablen;
with TextberechnungenHoeheSFML;

package body AnzeigeZusatztextKartengroesseSFML is

   procedure AnzeigeZusatztextKartengröße
     (AktuelleAuswahlExtern : in Natural)
   is begin
      
      TextFestlegen (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      PositionFestlegen;
      
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
   
   
   
   procedure TextFestlegen
     (AktuelleAuswahlExtern : in Natural)
   is begin
    
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                         str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => SystemKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum) - 1,
                                                                                                      WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum) & TextKonstanten.StandardAbstand & "5x"
                                         & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv (ZahlExtern => KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse)) & "x"
                                         & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv (ZahlExtern => KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse)));
      
      case
        AktuelleAuswahlExtern
      is
         when 0 =>
            null;
            
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                               str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => SystemKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum),
                                                                                                            WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum) & TextKonstanten.StandardAbstand & "5x"
                                               & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv
                                                                      (ZahlExtern => KartenKonstanten.StandardKartengrößen (StandardKartengrößen (AktuelleAuswahlExtern)).YAchse))
                                               & "x"
                                               & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv
                                                                      (ZahlExtern => KartenKonstanten.StandardKartengrößen (StandardKartengrößen (AktuelleAuswahlExtern)).XAchse)));
      end case;
      
   end TextFestlegen;
   
   
   
   procedure PositionFestlegen
   is begin
      
      PositionText.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                                                            ViewbreiteExtern => GrafikEinstellungenSFML.AktuelleFensterAuflösung.x);
      PositionText.y := InteraktionAuswahl.LetzteTextpositionKartengröße + TextberechnungenHoeheSFML.Zeilenabstand;
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                    position => PositionText);
      
      PositionText.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                                                            ViewbreiteExtern => GrafikEinstellungenSFML.AktuelleFensterAuflösung.x);
      PositionText.y := PositionText.y + TextberechnungenHoeheSFML.Zeilenabstand;
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                    position => PositionText);
      
   end PositionFestlegen;

end AnzeigeZusatztextKartengroesseSFML;

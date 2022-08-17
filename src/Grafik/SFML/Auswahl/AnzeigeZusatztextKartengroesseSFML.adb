pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with SystemKonstanten;
with MenueDatentypen;
with KartenKonstanten;
with TextKonstanten;
with TextaccessVariablen;

with GrafikEinstellungenSFML;
with AuswahlMenuesStringsSetzen;
with KartengeneratorVariablen;
with TextberechnungenBreiteSFML;
with TextberechnungenHoeheSFML;

package body AnzeigeZusatztextKartengroesseSFML is

   function AnzeigeZusatztextKartengröße
     (AktuelleAuswahlExtern : in Natural;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      TextFestlegen (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      Rückgabewert := PositionFestlegen (ViewflächeExtern   => ViewflächeExtern,
                                          TextpositionExtern => TextpositionExtern);
      
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
      
      return Rückgabewert;
      
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
          --  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
          --                                     str  => "LL");
            
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
   
   
   
   function PositionFestlegen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      AktuelleTextbreite := TextpositionExtern.x;
      Textposition.y := TextpositionExtern.y + TextberechnungenHoeheSFML.Zeilenabstand;
      Textposition.x := ViewflächeExtern.x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (1));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                    position => Textposition);
      
      NeueTextbreite := TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ZusatztextKartengrößeAccess (1)).width;
      
      if
        NeueTextbreite > AktuelleTextbreite
      then
         AktuelleTextbreite := NeueTextbreite;
         
      else
         null;
      end if;
      
      Textposition.x := ViewflächeExtern.x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (2));
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                    position => Textposition);
      
      NeueTextbreite := TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ZusatztextKartengrößeAccess (2)).width;
      
      if
        NeueTextbreite > AktuelleTextbreite
      then
         AktuelleTextbreite := NeueTextbreite;
         
      else
         null;
      end if;
      
      return (AktuelleTextbreite, Textposition.y);
      
   end PositionFestlegen;

end AnzeigeZusatztextKartengroesseSFML;

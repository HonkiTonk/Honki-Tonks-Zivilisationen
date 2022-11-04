pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with SystemKonstanten;
with MenueDatentypen;
with KartenKonstanten;
with TextKonstanten;
with TextaccessVariablen;

with EinstellungenGrafik;
with MenuestringsSetzenGrafik;
with KartengeneratorVariablenLogik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;

package body ZusatztextKartengroesseGrafik is

   function ZusatztextKartengröße
     (AktuelleAuswahlExtern : in Natural;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      TextFestlegen (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      Rückgabewert := PositionFestlegen (ViewflächeExtern      => ViewflächeExtern,
                                          RealeViewbreiteExtern => RealeViewbreiteExtern);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ZusatztextKartengrößeAccess (1));
      
      case
        AktuelleAuswahlExtern
      is
         when 0 =>
            null;
            
         when others =>
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.ZusatztextKartengrößeAccess (2));
      end case;
      
      return Rückgabewert;
      
   end ZusatztextKartengröße;
   
   
   
   procedure TextFestlegen
     (AktuelleAuswahlExtern : in Natural)
   is begin
    
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                         str  => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => SystemKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum) - 1,
                                                                                              WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum) & TextKonstanten.StandardAbstand & "5x"
                                         & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv (ZahlExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse)) & "x"
                                         & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv (ZahlExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse)));
      
      case
        AktuelleAuswahlExtern
      is
         when 0 =>
            null;
            
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                               str  => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => SystemKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum),
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
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := ViewflächeExtern.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                                                              ViewbreiteExtern => RealeViewbreiteExtern);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                    position => Textposition);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                                                          TextbreiteExtern => ViewflächeExtern.x);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                                                              ViewbreiteExtern => RealeViewbreiteExtern);
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                    position => Textposition);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                                                          TextbreiteExtern => Textbreite);
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
   end PositionFestlegen;

end ZusatztextKartengroesseGrafik;

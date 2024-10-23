with Sf.Graphics.Text;

with MenueKonstanten;
with MenueDatentypen;
with KartenKonstanten;
with TextKonstanten;
with TextaccessVariablen;
with AuswahlKonstanten;

with TextaccessverwaltungssystemEinfachGrafik;
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
      
      TextaccessverwaltungssystemEinfachGrafik.Zeichnen (TextaccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (1));
      
      case
        AktuelleAuswahlExtern
      is
         when AuswahlKonstanten.LeerAuswahl =>
            null;
            
         when others =>
            TextaccessverwaltungssystemEinfachGrafik.Zeichnen (TextaccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (2));
      end case;
      
      return Rückgabewert;
      
   end ZusatztextKartengröße;
   
   
   
   procedure TextFestlegen
     (AktuelleAuswahlExtern : in Natural)
   is begin
    
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                         str  => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => MenueKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum) - 1,
                                                                                              WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum) & TextKonstanten.StandardAbstand & Ebenenanzahl
                                         & SenkrechteAlsString (ZahlExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte) & KleinesX
                                         & WaagerechteAlsString (ZahlExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte));
      
      case
        AktuelleAuswahlExtern
      is
         when AuswahlKonstanten.LeerAuswahl =>
            null;
            
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                               str  => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => MenueKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum),
                                                                                                    WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum) & TextKonstanten.StandardAbstand & Ebenenanzahl
                                               & SenkrechteAlsString (ZahlExtern => KartenKonstanten.StandardKartengrößen (StandardKartengrößen (AktuelleAuswahlExtern)).Senkrechte) & KleinesX
                                               & WaagerechteAlsString (ZahlExtern => KartenKonstanten.StandardKartengrößen (StandardKartengrößen (AktuelleAuswahlExtern)).Waagerechte));
      end case;
      
   end TextFestlegen;
   
   
   
   function PositionFestlegen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := ViewflächeExtern.y + TextberechnungenHoeheGrafik.Zeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                                                              ViewbreiteExtern => RealeViewbreiteExtern);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                    position => Textposition);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (1),
                                                                          TextbreiteExtern => ViewflächeExtern.x);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                                                              ViewbreiteExtern => RealeViewbreiteExtern);
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                    position => Textposition);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ZusatztextKartengrößeAccess (2),
                                                                          TextbreiteExtern => Textbreite);
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
      
      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand);
      
   end PositionFestlegen;

end ZusatztextKartengroesseGrafik;

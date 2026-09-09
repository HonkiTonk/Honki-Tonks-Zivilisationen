with Sf.Graphics.Text;

with TextKonstantenHTSEB;

with MenueKonstanten;
with MenueDatentypen;
with TextaccessVariablen;

with TextaccessverwaltungssystemEinfachGrafik;
with MenuestringsSetzenGrafik;
with KartengeneratorVariablenLogik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;

-- Das hier in eine Funktion zusammenfassen? äöü
-- Sollte ich mehr hinzufügen müsste ich es dann aber eventuell wieder trennen. äöü
package body ZusatztextKartenebeneGrafik is

   function ZusatztextKartenebene
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      TextFestlegen;
      
      return TextAnzeigen (ViewflächeExtern      => ViewflächeExtern,
                           RealeViewbreiteExtern => RealeViewbreiteExtern);
      
   end ZusatztextKartenebene;
   
   
   
   procedure TextFestlegen
   is begin
      
      -- Eventuell eine Funktion schreiben die eine Textzeile durchgeht bis ein Leerzeichen erscheint und dann nur den Teil davor zurückgibt? äöü
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartenebenenAccess (1),
                                         str  => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => MenueKonstanten.EndeMenü (MenueDatentypen.Kartenebene_Menü_Enum),
                                                                                              WelchesMenüExtern => MenueDatentypen.Kartenebene_Menü_Enum) & TextKonstantenHTSEB.StandardAbstand
                                         & MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => Zusatztext (KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang),
                                                                                        WelchesMenüExtern => MenueDatentypen.Kartenebene_Menü_Enum)
                                         & Trennbereich & MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => Zusatztext (KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde),
                                                                                                       WelchesMenüExtern => MenueDatentypen.Kartenebene_Menü_Enum));
      
   end TextFestlegen;
   
   
   
   function TextAnzeigen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := ViewflächeExtern.y + TextberechnungenHoeheGrafik.Zeilenabstand;
      Textbreite := RealeViewbreiteExtern;
               
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ZusatztextKartenebenenAccess (1),
                                                                              ViewbreiteExtern => Textbreite);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartenebenenAccess (1),
                                    position => Textposition);
         
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ZusatztextKartenebenenAccess (1),
                                                                          TextbreiteExtern => Textbreite);
         
      TextaccessverwaltungssystemEinfachGrafik.Zeichnen (TextaccessExtern => TextaccessVariablen.ZusatztextKartenebenenAccess (1));
      
      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand);
      
   end TextAnzeigen;

end ZusatztextKartenebeneGrafik;

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
      
      Schleifenabzug := 5;
      
      ZusatztextKartenebeneSchleife:
      for ZusatztextKartenebeneSchleifenwert in TextaccessVariablen.ZusatztextKartenebenenAccess'First .. TextaccessVariablen.ZusatztextKartenebenenAccess'Last - 1 loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartenebenenAccess (ZusatztextKartenebeneSchleifenwert),
                                            str  => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => MenueKonstanten.EndeMenü (MenueDatentypen.Kartenebene_Menü_Enum) - Schleifenabzug,
                                                                                                 WelchesMenüExtern => MenueDatentypen.Kartenebene_Menü_Enum));
         
         Schleifenabzug := Schleifenabzug - 1;
         
      end loop ZusatztextKartenebeneSchleife;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextKartenebenenAccess (6),
                                         str  => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => MenueKonstanten.EndeMenü (MenueDatentypen.Kartenebene_Menü_Enum) - Schleifenabzug,
                                                                                              WelchesMenüExtern => MenueDatentypen.Kartenebene_Menü_Enum) & TextKonstantenHTSEB.StandardAbstand
                                         & EbeneAlsString (ZahlExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang) & Trennbereich
                                         & EbeneAlsString (ZahlExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde));
      
   end TextFestlegen;
   
   
   
   function TextAnzeigen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := ViewflächeExtern.y + TextberechnungenHoeheGrafik.Zeilenabstand;
      Textbreite := RealeViewbreiteExtern;
      
      TextanzeigeSchleife:
      for TextanzeigeSchleifenwert in TextaccessVariablen.ZusatztextKartenebenenAccess'Range loop
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ZusatztextKartenebenenAccess (TextanzeigeSchleifenwert),
                                                                                 ViewbreiteExtern => Textbreite);
      
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextKartenebenenAccess (TextanzeigeSchleifenwert),
                                       position => Textposition);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
      
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ZusatztextKartenebenenAccess (TextanzeigeSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         TextaccessverwaltungssystemEinfachGrafik.Zeichnen (TextaccessExtern => TextaccessVariablen.ZusatztextKartenebenenAccess (TextanzeigeSchleifenwert));
         
      end loop TextanzeigeSchleife;
      
      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand);
      
   end TextAnzeigen;

end ZusatztextKartenebeneGrafik;

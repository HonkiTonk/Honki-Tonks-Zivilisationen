with Sf.Graphics.Text;

with Views;
with GrafikDatentypen;
with TextaccessVariablen;
with InteraktionAuswahl;
with ViewKonstanten;
with GrafikKonstanten;

with HintergrundGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextaccessverwaltungssystemGrafik;

package body StadtbefehleGrafik is

   procedure Stadtbefehle
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtBefehle).width,
                                                                                              GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtBefehle).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtBefehle),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtBefehle));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      Textbreite := GrafikKonstanten.Nullwert;

      PositionenSchleife:
      for PositionSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert),
                                                                                 ViewbreiteExtern => Viewfläche.x);
         
         TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert),
                                                             PositionExtern   => Textposition);

         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         Textbox := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert));
         Textbox.left := GrafikKonstanten.Nullwert;
         Textbox.width := Viewfläche.x;
         InteraktionAuswahl.PositionenStadtbefehle (PositionSchleifenwert) := Textbox;
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
         
      end loop PositionenSchleife;

      Viewfläche := (Textbreite, Textposition.y);
      
   end Stadtbefehle;

end StadtbefehleGrafik;

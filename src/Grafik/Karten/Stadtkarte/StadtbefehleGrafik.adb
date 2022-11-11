with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with Views;
with GrafikDatentypen;
with TextaccessVariablen;
with InteraktionAuswahl;

with HintergrundGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;

package body StadtbefehleGrafik is

   procedure Stadtbefehle
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Stadtbereich (3).width, GrafikRecordKonstanten.Stadtbereich (3).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (3),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (3));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      Textbreite := 0.00;

      PositionenSchleife:
      for PositionSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert),
                                                                                 ViewbreiteExtern => Viewfläche.x);
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert),
                                       position => Textposition);

         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         Textbox := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert));
         Textbox.left := 0.00;
         Textbox.width := Viewfläche.x;
         InteraktionAuswahl.PositionenStadtbefehle (PositionSchleifenwert) := Textbox;
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert));
         
      end loop PositionenSchleife;

      Viewfläche := (Textbreite, Textposition.y);
      
   end Stadtbefehle;

end StadtbefehleGrafik;

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
with TextaccessverwaltungssystemEinfachGrafik;

package body StadtbefehleGrafik is

   procedure Stadtbefehle
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtBefehle).width,
                                                                                              GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtBefehle).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtBefehle),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtBefehle));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Seitenleiste_Enum,
                                    AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      Textbreite := GrafikKonstanten.Nullwert;

      PositionenSchleife:
      for PositionSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert),
                                                                                 ViewbreiteExtern => Viewfläche.x);
         
         TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert),
                                                                    PositionExtern   => Textposition);

         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         Textbox := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.StadtbefehleAccess (PositionSchleifenwert));
         Textbox.left := GrafikKonstanten.Nullwert;
         Textbox.width := Viewfläche.x;
         InteraktionAuswahl.PositionenStadtbefehle (PositionSchleifenwert) := Textbox;
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
         
      end loop PositionenSchleife;

      Viewfläche := (Textbreite, Textposition.y);
      
   end Stadtbefehle;

end StadtbefehleGrafik;

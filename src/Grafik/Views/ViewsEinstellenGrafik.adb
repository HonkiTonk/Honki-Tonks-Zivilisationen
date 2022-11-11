with Sf.Graphics.View;
with Sf.Graphics.RenderWindow;

with EinstellungenGrafik;

package body ViewsEinstellenGrafik is
   
   procedure ViewEinstellen
     (ViewExtern : in Sf.Graphics.sfView_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f;
      AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect)
   is begin
      
      Sf.Graphics.View.setSize (view => ViewExtern,
                                size => GrößeExtern);
      Sf.Graphics.View.setCenter (view   => ViewExtern,
                                  center => (GrößeExtern.x / 2.00, GrößeExtern.y / 2.00));
      Sf.Graphics.View.setViewport (view     => ViewExtern,
                                    viewport => AnzeigebereichExtern);
      
      Sf.Graphics.RenderWindow.setView (renderWindow => EinstellungenGrafik.FensterAccess,
                                        view         => ViewExtern);
      
   end ViewEinstellen;
   
   
   
   function ViewflächeAuflösungAnpassen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      if
        ViewflächeExtern.x < EinstellungenGrafik.AktuelleFensterAuflösung.x
      then
         Viewfläche.x := EinstellungenGrafik.AktuelleFensterAuflösung.x;
         
      else
         Viewfläche.x := ViewflächeExtern.x;
      end if;
      
      if
        ViewflächeExtern.y < EinstellungenGrafik.AktuelleFensterAuflösung.y
      then
         Viewfläche.y := EinstellungenGrafik.AktuelleFensterAuflösung.y;
         
      else
         Viewfläche.y := ViewflächeExtern.y;
      end if;
      
      return Viewfläche;
      
   end ViewflächeAuflösungAnpassen;
   
   
   
   function ViewflächeVariabelAnpassen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      VerhältnisExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      if
        ViewflächeExtern.x < EinstellungenGrafik.AktuelleFensterAuflösung.x * VerhältnisExtern.x
      then
         ViewflächeVariabel.x := EinstellungenGrafik.AktuelleFensterAuflösung.x * VerhältnisExtern.x;
         
      else
         ViewflächeVariabel.x := ViewflächeExtern.x;
      end if;
      
      if
        ViewflächeExtern.y < EinstellungenGrafik.AktuelleFensterAuflösung.y * VerhältnisExtern.y
      then
         ViewflächeVariabel.y := EinstellungenGrafik.AktuelleFensterAuflösung.y * VerhältnisExtern.y;
         
      else
         ViewflächeVariabel.y := ViewflächeExtern.y;
      end if;
      
      return ViewflächeVariabel;
      
   end ViewflächeVariabelAnpassen;

end ViewsEinstellenGrafik;

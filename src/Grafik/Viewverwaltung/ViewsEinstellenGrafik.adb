with Sf.Graphics.View;
with Sf.Graphics.RenderWindow;

with GrafikKonstanten;

with FensterGrafik;

package body ViewsEinstellenGrafik is
   
   procedure ViewEinstellen
     (ViewExtern : in Sf.Graphics.sfView_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f;
      AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect)
   is begin
      
      Sf.Graphics.View.setSize (view => ViewExtern,
                                size => GrößeExtern);
      Sf.Graphics.View.setCenter (view   => ViewExtern,
                                  center => (GrößeExtern.x / GrafikKonstanten.Halbierung, GrößeExtern.y / GrafikKonstanten.Halbierung));
      Sf.Graphics.View.setViewport (view     => ViewExtern,
                                    viewport => AnzeigebereichExtern);
      
      Sf.Graphics.RenderWindow.setView (renderWindow => FensterGrafik.FensterLesen,
                                        view         => ViewExtern);
      
   end ViewEinstellen;
   
   
   
   procedure ViewEinstellenBewegen
     (ViewExtern : in Sf.Graphics.sfView_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f;
      BewegungExtern : in Sf.System.Vector2.sfVector2f;
      AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect)
   is begin
      
      Sf.Graphics.View.setSize (view => ViewExtern,
                                size => GrößeExtern);
      Sf.Graphics.View.setCenter (view   => ViewExtern,
                                  center => (GrößeExtern.x / GrafikKonstanten.Halbierung, GrößeExtern.y / GrafikKonstanten.Halbierung));
      Sf.Graphics.View.setViewport (view     => ViewExtern,
                                    viewport => AnzeigebereichExtern);
      
      Sf.Graphics.View.move (view   => ViewExtern,
                             offset => BewegungExtern);
      
      Sf.Graphics.RenderWindow.setView (renderWindow => FensterGrafik.FensterLesen,
                                        view         => ViewExtern);
      
   end ViewEinstellenBewegen;
   
   
   
   procedure ViewSetzen
     (ViewExtern : in Sf.Graphics.sfView_Ptr)
   is begin
      
      Sf.Graphics.RenderWindow.setView (renderWindow => FensterGrafik.FensterLesen,
                                        view         => ViewExtern);
      
   end ViewSetzen;
   
   
   
   -- Sf.System.Vector2.sfVector2f ist ein Float Record, könnte man das auslagern ohne die SFML einbindun zu müssen? äöü
   function ViewflächeAuflösungAnpassen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      if
        ViewflächeExtern.x < FensterGrafik.AktuelleAuflösung.x
      then
         Viewfläche.x := FensterGrafik.AktuelleAuflösung.x;
         
      else
         Viewfläche.x := ViewflächeExtern.x;
      end if;
      
      if
        ViewflächeExtern.y < FensterGrafik.AktuelleAuflösung.y
      then
         Viewfläche.y := FensterGrafik.AktuelleAuflösung.y;
         
      else
         Viewfläche.y := ViewflächeExtern.y;
      end if;
      
      return Viewfläche;
      
   end ViewflächeAuflösungAnpassen;
   
   
   
   function ViewflächeAnpassen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      ViewflächeVariabel.x := FensterGrafik.AktuelleAuflösung.x;
      
      if
        ViewflächeExtern.y < FensterGrafik.AktuelleAuflösung.y
      then
         Viewfläche.y := FensterGrafik.AktuelleAuflösung.y;
         
      else
         Viewfläche.y := ViewflächeExtern.y;
      end if;
      
      return Viewfläche;
      
   end ViewflächeAnpassen;
   
   
   
   -- Das hier verwenden wenn mehrere Texte in der Breite angezeigt werden sollen, beispielsweise wie in SteuerungsmenueGrafik.
   function ViewflächeVariabelAnpassen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      VerhältnisExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      if
        ViewflächeExtern.x < FensterGrafik.AktuelleAuflösung.x * VerhältnisExtern.x
      then
         ViewflächeVariabel.x := FensterGrafik.AktuelleAuflösung.x * VerhältnisExtern.x;
         
      else
         ViewflächeVariabel.x := ViewflächeExtern.x;
      end if;
      
      if
        ViewflächeExtern.y < FensterGrafik.AktuelleAuflösung.y * VerhältnisExtern.y
      then
         ViewflächeVariabel.y := FensterGrafik.AktuelleAuflösung.y * VerhältnisExtern.y;
         
      else
         ViewflächeVariabel.y := ViewflächeExtern.y;
      end if;
      
      return ViewflächeVariabel;
      
   end ViewflächeVariabelAnpassen;
   
   
   
   -- Das hier zum allgemeinen Fall machen. äöü
   function ViewflächeWaagerechteFestSenkrechteVariabel
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      VerhältnisExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      ViewflächeVariabel.x := FensterGrafik.AktuelleAuflösung.x * VerhältnisExtern.x;
      
      if
        ViewflächeExtern.y < FensterGrafik.AktuelleAuflösung.y * VerhältnisExtern.y
      then
         ViewflächeVariabel.y := FensterGrafik.AktuelleAuflösung.y * VerhältnisExtern.y;
         
      else
         ViewflächeVariabel.y := ViewflächeExtern.y;
      end if;
      
      return ViewflächeVariabel;
      
   end ViewflächeWaagerechteFestSenkrechteVariabel;

end ViewsEinstellenGrafik;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Rect;

package ViewsEinstellenSFML is
   
   procedure ViewEinstellen
     (ViewExtern : in Sf.Graphics.sfView_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f;
      AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect)
     with
       Pre => (
                 ViewExtern /= null
               and
                 GrößeExtern.x /= 0.00
               and
                 GrößeExtern.y /= 0.00
               and
                 AnzeigebereichExtern.left >= 0.00
               and
                 AnzeigebereichExtern.top >= 0.00
               and
                 AnzeigebereichExtern.width > 0.00
               and
                 AnzeigebereichExtern.height > 0.00
              );
   
   
   
   function ViewflächeAuflösungAnpassen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x > 0.00
               and
                 ViewflächeExtern.y > 0.00
              ),
         
       Post => (
                  ViewflächeAuflösungAnpassen'Result.x > 0.00
                and
                  ViewflächeAuflösungAnpassen'Result.y > 0.00
               );
      
   function ViewflächeVariabelAnpassen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      VerhältnisExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x > 0.00
               and
                 ViewflächeExtern.y > 0.00
               and
                 VerhältnisExtern.x > 0.00
               and
                 VerhältnisExtern.y > 0.00
              ),
         
       Post => (
                  ViewflächeVariabelAnpassen'Result.x > 0.00
                and
                  ViewflächeVariabelAnpassen'Result.y > 0.00
               );
   
private
   
   Viewfläche : Sf.System.Vector2.sfVector2f;

end ViewsEinstellenSFML;
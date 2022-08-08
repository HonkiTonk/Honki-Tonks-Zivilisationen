pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Rect;

package ViewsEinstellenSFML is
   
   procedure ViewEinstellen
     (ViewExtern : in Sf.Graphics.sfView_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 ViewExtern /= null
               and
                 GrößeExtern.x /= 0.00
               and
                 GrößeExtern.y /= 0.00
              );
   
   
   
   function Anzeigeverhätlnis
     return Sf.Graphics.Rect.sfFloatRect
     with
       Post => (
                  Anzeigeverhätlnis'Result.left >= 0.00
                and
                  Anzeigeverhätlnis'Result.top >= 0.00
                and
                  Anzeigeverhätlnis'Result.width >= 0.00
                and
                  Anzeigeverhätlnis'Result.height >= 0.00
               );

end ViewsEinstellenSFML;

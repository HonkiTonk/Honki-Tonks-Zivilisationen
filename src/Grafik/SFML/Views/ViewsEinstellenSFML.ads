pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.System.Vector2;

package ViewsEinstellenSFML is

   procedure StandardviewGeändert;
   
   procedure ViewEinstellen
     (ViewExtern : in Sf.Graphics.sfView_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f;
      ZentrumExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 ViewExtern /= null
               and
                 GrößeExtern.x /= 0.00
               and
                 GrößeExtern.y /= 0.00
               and
                 ZentrumExtern.x > 0.00
               and
                 ZentrumExtern.y > 0.00
              );

end ViewsEinstellenSFML;

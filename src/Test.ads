with Sf.Graphics.Rect;
with Sf.System.Vector2;

package Test is
   
   procedure Test;
   
private

   FloatRectangle : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 100.00, 100.00);
   IntegerRectangle : constant Sf.Graphics.Rect.sfIntRect := (0, 0, 100, 100);
   
   FloatPoint : constant Sf.System.Vector2.sfVector2f := (10.00, 10.00);
   IntegerPoint : constant Sf.System.Vector2.sfVector2i := (10, 10);

end Test;

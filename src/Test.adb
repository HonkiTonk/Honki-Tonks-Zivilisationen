with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Sf; use Sf;

package body Test is

   procedure Test
   is begin
      
      case
        Sf.Graphics.Rect.contains (rect => FloatRectangle,
                                   x    => FloatPoint.x,
                                   y    => FloatPoint.y)
      is
         when Sf.sfTrue =>
            Put_Line ("Floatpoint is inside.");
            
         when Sf.sfFalse =>
            Put_Line ("Floatpoint is outside.");
      end case;
      
      case
        Sf.Graphics.Rect.contains (rect => IntegerRectangle,
                                   x    => Integer (IntegerPoint.x),
                                   y    => Integer (IntegerPoint.y))
      is
         when Sf.sfTrue =>
            Put_Line ("Integerpoint is inside.");
            
         when Sf.sfFalse =>
            Put_Line ("Integerpoint is outside.");
      end case;
      
   end Test;

end Test;

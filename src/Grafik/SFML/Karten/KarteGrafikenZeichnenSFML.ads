pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.System.Vector2;

package KarteGrafikenZeichnenSFML is

   procedure SpriteZeichnen
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre =>
         (SpriteAccesExtern /= null
          and
            PositionExtern.x >= 0.00
          and
            PositionExtern.y >= 0.00
          and
            SkalierungExtern.x > 0.00
          and
            SkalierungExtern.y > 0.00);

end KarteGrafikenZeichnenSFML;

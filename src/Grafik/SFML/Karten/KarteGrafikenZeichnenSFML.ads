pragma SPARK_Mode (On);

with Sf.Graphics;
with Sf.System.Vector2;

package KarteGrafikenZeichnenSFML is

   procedure SpriteZeichnen
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f);
   
private
   
   

end KarteGrafikenZeichnenSFML;

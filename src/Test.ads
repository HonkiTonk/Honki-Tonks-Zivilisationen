pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics;
with Sf.Graphics.Sprite;

package Test is
   
   procedure Test;
   
private
   
   TestAccess : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   SpriteAccess : Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   
end Test;

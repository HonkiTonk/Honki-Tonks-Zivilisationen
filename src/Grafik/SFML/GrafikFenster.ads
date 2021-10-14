pragma SPARK_Mode (On);

with Sf.Graphics;
with Sf.Graphics.Sprite;

package GrafikFenster is

   procedure FensterFarbe;
   procedure TexturAnzeigen;
   procedure TextAnzeigen;

private

   Hintergrundbild : Sf.Graphics.sfTexture_Ptr;
   Sprite : Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

end GrafikFenster;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

private with Sf.Graphics;
private with Sf.Graphics.Sprite;

package ZusatztextKartenformGrafik is

   procedure ZusatztextKartenform
     (AktuelleAuswahlExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f);

private

   Texturfläche : Sf.System.Vector2.sfVector2f;
   Texturanfang : Sf.System.Vector2.sfVector2f;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

end ZusatztextKartenformGrafik;

with Sf.System.Vector2;

private with Sf.Graphics;
private with Sf.Graphics.Sprite;

package ZusatztextKartenformGrafik is
   pragma Elaborate_Body;

   procedure ZusatztextKartenform
     (AktuelleAuswahlExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f);

private

   Texturfläche : Sf.System.Vector2.sfVector2f;
   Texturanfang : Sf.System.Vector2.sfVector2f;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

end ZusatztextKartenformGrafik;

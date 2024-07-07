with Sf.System.Vector2;

private with Sf.Graphics;
private with Sf.Graphics.Sprite;

private with GrafikDatentypen;

package ZusatztextKartenformGrafik is
   pragma Elaborate_Body;

   procedure ZusatztextKartenform
     (AktuelleAuswahlExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f);

private

   ÜbergangOben : constant Positive := 1;
   ÜbergangUnten : constant Positive := 2;
   ÜbergangNorden : constant Positive := 3;
   ÜbergangSüden : constant Positive := 4;
   ÜbergangWesten : constant Positive := 5;
   ÜbergangOsten : constant Positive := 6;

   Kartenform : GrafikDatentypen.Hintergrund_Kartenformen_Enum;

   Texturfläche : Sf.System.Vector2.sfVector2f;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

end ZusatztextKartenformGrafik;

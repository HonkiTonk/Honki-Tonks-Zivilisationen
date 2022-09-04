pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.System.Vector2;

private with Sf.Graphics.Sprite;
private with Sf.Graphics.Color;

package KartenspritesZeichnenGrafik is

   function SpriteGezeichnetKartenfeld
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
      return Boolean
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   function SpriteGezeichnetStadtfeld
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   function SpriteGezeichnetStadtgrund
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

private

   Farbe : Sf.Graphics.Color.sfColor;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   procedure SpriteZeichnen
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
     with
       Pre => (
                 SpriteAccesExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 SkalierungExtern.x > 0.00
               and
                 SkalierungExtern.y > 0.00
              );

end KartenspritesZeichnenGrafik;

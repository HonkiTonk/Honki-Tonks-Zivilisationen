pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.System.Vector2;

package KartenspritesZeichnenSFML is

   function SpriteGezeichnetKartenfeld
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
     with
       Pre => (
                 SpriteAccesExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   function SpriteGezeichnetStadtfeld
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
     with
       Pre => (
                 SpriteAccesExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   function SpriteGezeichnetStadtgrund
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
     with
       Pre => (
                 SpriteAccesExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

private

   procedure SpriteZeichnen
     (SpriteAccesExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
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

end KartenspritesZeichnenSFML;

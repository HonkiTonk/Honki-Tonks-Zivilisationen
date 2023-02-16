with Sf.Graphics;
with Sf.Graphics.Color;
with Sf.System.Vector2;
with Sf.Graphics.Rect;

package SpritesverwaltungssystemGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfSprite_Ptr;
   use type Sf.Graphics.sfTexture_Ptr;
   
   procedure SetzenBereichSkalierenZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      TexturExtern : in Sf.Graphics.sfTexture_Ptr;
      BereichExtern : in Sf.Graphics.Rect.sfIntRect;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 TexturExtern /= null
               and
                 SkalierungExtern.x > 0.00
               and
                 SkalierungExtern.y > 0.00
              );
   
   procedure PositionSkalierungZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 SkalierungExtern.x > 0.00
               and
                 SkalierungExtern.y > 0.00
              );
   
   procedure PositionSkalieren
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 SkalierungExtern.x > 0.00
               and
                 SkalierungExtern.y > 0.00
              );
   
   procedure PositionFarbeZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 SpriteAccessExtern /= null
              );
   
   procedure PositionZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 SpriteAccessExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   procedure FarbeZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 SpriteAccessExtern /= null
              );

end SpritesverwaltungssystemGrafik;

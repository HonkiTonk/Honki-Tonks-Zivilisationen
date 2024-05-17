with Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Rect;

private with Sf.Graphics.Sprite;
private with Sf.Graphics.Color;

package KartenspritesZeichnenGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfSprite_Ptr;

   procedure KartenfeldZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   procedure KartenfeldZeichnenNeu
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturenbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   procedure StadtbewirtschaftungZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturenbereichExtern : in Sf.System.Vector2.sfVector2f;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 TexturenbereichExtern.x >= 0.00
               and
                 TexturenbereichExtern.y >= 0.00
              );

   procedure StadtkarteZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr);

   procedure SpriteZeichnenVariabel
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      GrößeExtern : in Sf.System.Vector2.sfVector2f;
      TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr)
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 GrößeExtern.x >= 0.00
               and
                 GrößeExtern.y >= 0.00
              );

private

   Skalierung : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   procedure DurchsichtigesSpriteZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
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

end KartenspritesZeichnenGrafik;

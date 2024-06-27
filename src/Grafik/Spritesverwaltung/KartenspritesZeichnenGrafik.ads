with Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Rect;

private with Sf.Graphics.Sprite;
private with Sf.Graphics.Color;

package KartenspritesZeichnenGrafik is
   pragma Elaborate_Body;

   -- Müsste ich hier nicht den Texturenaccess auf /= null prüfen können? Oder wird das hier noch gesetzt? äöü
   -- Müsste für den Bereich nicht auch immer > 0/0.00 reichen? äöü
   procedure KartenfeldZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
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
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 TexturbereichExtern.left >= 0
               and
                 TexturbereichExtern.top >= 0
               and
                 TexturbereichExtern.width >= 0
               and
                 TexturbereichExtern.height >= 0
              );

   procedure StadtkarteZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturenbereichExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 TexturenbereichExtern.x >= 0.00
               and
                 TexturenbereichExtern.y >= 0.00
              );

   procedure SpriteZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
     with
       Pre => (
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 SkalierungExtern.x > 0.00
               and
                 SkalierungExtern.y > 0.00
              );

private

   Skalierung : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

end KartenspritesZeichnenGrafik;

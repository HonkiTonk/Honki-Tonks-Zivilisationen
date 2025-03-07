with Sf;
with Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Rect;

private with Sf.Graphics.Sprite;
private with Sf.Graphics.Color;

with SpeziesDatentypen;
with GrafikDatentypen;

package HintergrundGrafik is
   pragma Elaborate_Body;

   procedure Aufteilung
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Gesamt_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 AbmessungenExtern.x >= 0.00
               and
                 AbmessungenExtern.y >= 0.00
              );

   procedure Hintergrund
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f;
      HintergrundExtern : in GrafikDatentypen.Hintergrund_Gesamt_Enum)
     with
       Pre => (
                 AbmessungenExtern.x >= 0.00
               and
                 AbmessungenExtern.y >= 0.00
              );

   procedure HintergrundPositionierbar
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
     with
       Pre => (
                 AbmessungenExtern.x >= 0.00
               and
                 AbmessungenExtern.y >= 0.00
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   -- Spezies kann hier nicht geprrüft werden da der Abspann eventuell ohne belegte Spezies ankommt!
   procedure Spezieshintergrund
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 AbmessungenExtern.x >= 0.00
               and
                 AbmessungenExtern.y >= 0.00
              );

private

   AktuelleSpezies : SpeziesDatentypen.Spezies_Enum;

   Skalierung : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;

   SpezieshintergrundSpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

end HintergrundGrafik;

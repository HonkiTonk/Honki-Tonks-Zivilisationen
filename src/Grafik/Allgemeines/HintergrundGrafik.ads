with Sf;
with Sf.Graphics;
with Sf.System.Vector2;

private with Sf.Graphics.Sprite;
private with Sf.Graphics.Color;

with SpeziesDatentypen;
with GrafikDatentypen;

package HintergrundGrafik is
   pragma Elaborate_Body;

   procedure Hintergrund
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 AbmessungenExtern.x >= 0.00
               and
                 AbmessungenExtern.y >= 0.00
              );

   procedure HintergrundPositionierbar
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
     with
       Pre => (
                 AbmessungenExtern.x >= 0.00
               and
                 AbmessungenExtern.y >= 0.00
              );

   -- Spezies kann hier nicht geprrüft werden da der Abspann eventuell ohne belegte Spezies ankommt!
   procedure Spezieshintergrund
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 AbmessungenExtern.x >= 0.00
               and
                 AbmessungenExtern.y >= 0.00
              );

private

   HintergrundSpritePositionierbarAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   SpezieshintergrundSpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   Farbe : Sf.Graphics.Color.sfColor;

end HintergrundGrafik;

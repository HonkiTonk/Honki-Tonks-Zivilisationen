with Sf.Graphics;
with Sf.System.Vector2;

private with Sf.Graphics.Sprite;
private with Sf.Graphics.Color;

with RassenDatentypen;
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

   -- Rasse kann hier nicht gerprüft werden da der Abspann eventuell ohne belegte Rasse ankommt!
   procedure Rassenhintergrund
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      HintergrundExtern : in GrafikDatentypen.Rassenhintergrund_Vorhanden_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 AbmessungenExtern.x >= 0.00
               and
                 AbmessungenExtern.y >= 0.00
              );

private

   HintergrundSpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   RassenhintergrundSpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   Farbe : Sf.Graphics.Color.sfColor;

end HintergrundGrafik;

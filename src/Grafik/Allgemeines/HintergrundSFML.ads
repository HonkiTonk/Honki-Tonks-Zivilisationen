pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.System.Vector2;

private with Sf.Graphics.Sprite;

with GrafikDatentypen;

package HintergrundSFML is

   procedure SeitenleisteHintergrund
     (AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 AbmessungenExtern.x > 0.00
               and
                 AbmessungenExtern.y > 0.00
              );

   procedure MenüHintergrund
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum;
      AbmessungenExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 AbmessungenExtern.x > 0.00
               and
                 AbmessungenExtern.y > 0.00
              );

private

   SeitenleistespriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   MenüspriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

end HintergrundSFML;

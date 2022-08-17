pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.System.Vector2;

private with Sf.Graphics.Sprite;

with GrafikDatentypen;

package HintergrundSFML is

   procedure StandardHintergrund
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum);

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

   procedure TextHintergrund
     (LinksRechtsExtern : in Boolean;
      AbstandÜberschriftExtern : in Float;
      VerhältnisTextfeldExtern : in Sf.System.Vector2.sfVector2f;
      StartpositionExtern : in Float)
     with
       Pre => (
                 VerhältnisTextfeldExtern.x > 0.00
               and
                 VerhältnisTextfeldExtern.y > 0.00
               and
                 StartpositionExtern >= 0.00
              );

private

   Nullposition : constant Sf.System.Vector2.sfVector2f := (0.00, 0.00);
   PositionHintergrund : Sf.System.Vector2.sfVector2f;

   HintergrundspriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   SeitenleistespriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   TextspriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   MenüspriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

end HintergrundSFML;

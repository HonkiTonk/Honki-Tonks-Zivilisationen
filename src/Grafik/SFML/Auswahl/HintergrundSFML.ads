pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.System.Vector2;

private with Sf.Graphics.Sprite;

with MenueDatentypen;
with GrafikDatentypen;

package HintergrundSFML is

   procedure StandardHintergrund
     (StandardHintergrundExtern : in GrafikDatentypen.Standard_Texturen_Enum);

   procedure MenüHintergrund
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum);

   procedure TextHintergrund
     (GebäudeEinheitExtern : in Boolean;
      AbstandÜberschriftExtern : in Float;
      VerhältnisTextfeldExtern : in Sf.System.Vector2.sfVector2f;
      StartpositionExtern : in Float);

private

   Nullposition : constant Sf.System.Vector2.sfVector2f := (0.00, 0.00);
   PositionHintergrund : Sf.System.Vector2.sfVector2f;

   HintergrundspriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

end HintergrundSFML;

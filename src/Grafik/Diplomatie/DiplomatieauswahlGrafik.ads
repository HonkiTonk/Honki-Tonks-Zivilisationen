pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

private with GrafikRecordKonstanten;

package DiplomatieauswahlGrafik is

   procedure Diplomatieauswahl
     (AuswahlExtern : in Natural);

private

   Textarrayanpassung : constant Positive := 2;

   Textbreite : Float;

   Text : Unbounded_Wide_Wide_String;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;

   function Textdarstellung
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Textdarstellung'Result.x >= 0.00
                and
                  Textdarstellung'Result.y >= 0.00
               );

end DiplomatieauswahlGrafik;
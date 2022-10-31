pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;
private with Sf.Graphics.Rect;

with GrafikRecordKonstanten;

package StadtbefehleGrafik is
   pragma Elaborate_Body;

   procedure Stadtbefehle;

private

   Textbreite : Float;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;

   Textbox : Sf.Graphics.Rect.sfFloatRect;

end StadtbefehleGrafik;

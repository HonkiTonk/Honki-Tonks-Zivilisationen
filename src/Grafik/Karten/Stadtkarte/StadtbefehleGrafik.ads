private with Sf.System.Vector2;
private with Sf.Graphics.Rect;

private with GrafikRecordKonstanten;

package StadtbefehleGrafik is
   pragma Elaborate_Body;

   procedure Stadtbefehle;

private

   Textbreite : Float;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;

   Textbox : Sf.Graphics.Rect.sfFloatRect;

end StadtbefehleGrafik;

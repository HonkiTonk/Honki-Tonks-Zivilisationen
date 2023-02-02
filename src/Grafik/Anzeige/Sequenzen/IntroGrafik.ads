private with Sf.System.Vector2;

private with GrafikRecordKonstanten;

package IntroGrafik is
   pragma Elaborate_Body;

   procedure Intro;

private

   Textbreite : Float;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;

end IntroGrafik;

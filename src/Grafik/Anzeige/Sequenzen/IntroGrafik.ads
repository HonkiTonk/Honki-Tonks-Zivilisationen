pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

private with GrafikRecordKonstanten;

package IntroGrafik is

   procedure Intro;

private

   Textbreite : Float;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;

end IntroGrafik;

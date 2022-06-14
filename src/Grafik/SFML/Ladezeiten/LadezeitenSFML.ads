pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

package LadezeitenSFML is

   procedure SpielweltErstellen;

private
   
   WelcheZeit : Positive;
   
   ZeilenAbstand : Float;
   
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;

end LadezeitenSFML;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

package AuswahlSFML is

   function AuswahlJaNeinSFML
     (FrageZeileExtern : in Positive)
      return Boolean;

private

   AktuelleAuswahl : Natural;

   Mausposition : Sf.System.Vector2.sfVector2f;

   function MausAuswahl
     return Natural;

end AuswahlSFML;

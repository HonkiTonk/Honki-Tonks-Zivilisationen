pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body AuswahlMenueSteuerungSFML is

   function AuswahlMenüSteuerung
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return ViewflächeExtern;
      
   end AuswahlMenüSteuerung;

end AuswahlMenueSteuerungSFML;

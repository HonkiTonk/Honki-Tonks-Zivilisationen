pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

package AuswahlMenueSteuerungSFML is

   function AuswahlMenüSteuerung
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f;
   
private
   
   

end AuswahlMenueSteuerungSFML;

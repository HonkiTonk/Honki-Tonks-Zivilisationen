pragma SPARK_Mode (On);

with Sf.Graphics;
use Sf.Graphics;

package GrafikStart is

   Fenster : Sf.Graphics.sfRenderWindow_Ptr;
   
   procedure FensterEntfernen;
   
   
   
   function FensterErzeugen
     return Boolean;

end GrafikStart;

pragma SPARK_Mode (On);

with Sf.Graphics;

package EingeleseneTexturen is

   type HintergrundArray is array (1 .. 2) of Sf.Graphics.sfTexture_Ptr;
   Hintergrund : HintergrundArray;

   Kartenfelder : Sf.Graphics.sfTexture_Ptr;

end EingeleseneTexturen;

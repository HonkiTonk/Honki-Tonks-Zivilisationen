pragma SPARK_Mode (On);

with Sf.Graphics;

package EingeleseneTexturenSFML is

   type HintergrundArray is array (1 .. 2) of Sf.Graphics.sfTexture_Ptr;
   Hintergrund : HintergrundArray;

   KartenfelderAccess : Sf.Graphics.sfTexture_Ptr;

   -- Kartenfelderarray anlegen?

end EingeleseneTexturenSFML;

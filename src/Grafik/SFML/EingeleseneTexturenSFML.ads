pragma SPARK_Mode (On);

with Sf.Graphics;

with KartenDatentypen;

package EingeleseneTexturenSFML is

   type HintergrundArray is array (1 .. 2) of Sf.Graphics.sfTexture_Ptr;
   Hintergrund : HintergrundArray := (others => null);

   type KartenfelderAccessArray is array (KartenDatentypen.Test'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenfelderAccess : KartenfelderAccessArray := (others => null);

end EingeleseneTexturenSFML;

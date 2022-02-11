pragma SPARK_Mode (On);

with Sf.Graphics;

with KartenDatentypen;
with EinheitStadtDatentypen;

package EingeleseneTexturenSFML is

   type HintergrundArray is array (1 .. 2) of Sf.Graphics.sfTexture_Ptr;
   Hintergrund : HintergrundArray := (others => null);

   type KartenfelderAccessArray is array (KartenDatentypen.Karten_Grund_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenfelderAccess : KartenfelderAccessArray := (others => null);

   type VerbesserungenAccessArray is array (KartenDatentypen.Karten_Verbesserung_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   VerbesserungenAccess : VerbesserungenAccessArray := (others => null);

   type EinheitenAccesArray is array (EinheitStadtDatentypen.EinheitenID'Range) of Sf.Graphics.sfTexture_Ptr;
   EinheitenAccess : EinheitenAccesArray := (others => null);

   type GebäudeAccessArray is array (EinheitStadtDatentypen.GebäudeID'Range) of Sf.Graphics.sfTexture_Ptr;
   GebäudeAccess : GebäudeAccessArray := (others => null);

end EingeleseneTexturenSFML;

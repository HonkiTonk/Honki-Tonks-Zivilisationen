pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;

with EinheitStadtDatentypen;
with SystemDatentypen;
with KartenGrundDatentypen;
with KartenVerbesserungDatentypen;

package EingeleseneTexturenSFML is

   type HintergrundAccessArray is array (1 .. 1) of Sf.Graphics.sfTexture_Ptr;
   HintergrundAccess : HintergrundAccessArray := (others => null);

   type KartenfelderAccessArray is array (KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenfelderAccess : KartenfelderAccessArray := (others => null);

   type VerbesserungenAccessArray is array (KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   VerbesserungenAccess : VerbesserungenAccessArray := (others => null);

   type EinheitenAccesArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.EinheitenID'Range) of Sf.Graphics.sfTexture_Ptr;
   EinheitenAccess : EinheitenAccesArray := (others => (others => null));

   type GebäudeAccessArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.GebäudeID'Range) of Sf.Graphics.sfTexture_Ptr;
   GebäudeAccess : GebäudeAccessArray := (others => (others => null));

end EingeleseneTexturenSFML;

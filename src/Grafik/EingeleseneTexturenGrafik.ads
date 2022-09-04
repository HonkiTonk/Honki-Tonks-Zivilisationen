pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;

with StadtDatentypen;
with EinheitenDatentypen;
with KartenverbesserungDatentypen;
with RassenDatentypen;
with GrafikDatentypen;

with KartengrundDatenbank;
with KartenflussDatenbank;
with KartenressourcenDatenbank;

package EingeleseneTexturenGrafik is

   -- Eventuell nach Bereiche aufteilen, damit dass hier nicht zu unübersichtlich wird? äöü
   -- Wenn dann in die gleichen Bereiche wie in EinlesenTexturen. äöü

   type HintergrundAccessArray is array (GrafikDatentypen.Hintergrund_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   HintergrundAccess : HintergrundAccessArray := (others => null);

   type KartenfelderAccessArray is array (KartengrundDatenbank.KartengrundlisteArray'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenfelderAccess : KartenfelderAccessArray := (others => null);

   type KartenflussAccessArray is array (KartenflussDatenbank.KartenflusslisteArray'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenflussAccess : KartenflussAccessArray := (others => null);

   type KartenressourcenAccessArray is array (KartenressourcenDatenbank.KartenressourcenlisteArray'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenressourceAccess : KartenressourcenAccessArray := (others => null);

   -- Auch auf Rasse erweitern, damit man verschieden aussehende Städte/Verbesserungen hat? äöü
   type VerbesserungenAccessArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   VerbesserungenAccess : VerbesserungenAccessArray := (others => null);

   type WegeAccessArray is array (KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   WegeAccess : WegeAccessArray := (others => null);

   type EinheitenAccesArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitenDatentypen.EinheitenID'Range) of Sf.Graphics.sfTexture_Ptr;
   EinheitenAccess : EinheitenAccesArray := (others => (others => null));

   type GebäudeAccessArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, StadtDatentypen.GebäudeID'Range) of Sf.Graphics.sfTexture_Ptr;
   GebäudeAccess : GebäudeAccessArray := (others => (others => null));

end EingeleseneTexturenGrafik;

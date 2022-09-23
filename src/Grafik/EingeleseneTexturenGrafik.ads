pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;

with StadtDatentypen;
with EinheitenDatentypen;
with KartenverbesserungDatentypen;
with RassenDatentypen;
with GrafikDatentypen;
with BefehleDatentypen;

with KartenDatenbank;

package EingeleseneTexturenGrafik is

   -- Eventuell nach Bereiche aufteilen, damit dass hier nicht zu unübersichtlich wird? äöü
   -- Wenn dann in die gleichen Bereiche wie in EinlesenTexturen. äöü

   type SystemAccessArray is array (BefehleDatentypen.Befehlsknöpfe_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   SystemAccess : SystemAccessArray := (others => null);

   type HintergrundAccessArray is array (GrafikDatentypen.Hintergrund_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   HintergrundAccess : HintergrundAccessArray := (others => null);

   type KartenfelderAccessArray is array (KartenDatenbank.KartengrundlisteArray'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenfelderAccess : KartenfelderAccessArray := (others => null);

   type KartenflussAccessArray is array (KartenDatenbank.KartenflusslisteArray'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenflussAccess : KartenflussAccessArray := (others => null);

   type KartenressourcenAccessArray is array (KartenDatenbank.KartenressourcenlisteArray'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenressourceAccess : KartenressourcenAccessArray := (others => null);

   -- Auch auf Rasse erweitern, damit man verschieden aussehende Städte/Verbesserungen hat? äöü
   type VerbesserungenAccessArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   VerbesserungenAccess : VerbesserungenAccessArray := (others => null);

   type WegeAccessArray is array (KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   WegeAccess : WegeAccessArray := (others => null);

   type RassenhintergrundAccessArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, GrafikDatentypen.Rassenhintergrund_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   RassenhintergrundAccess : RassenhintergrundAccessArray := (others => (others => null));

   type EinheitenAccesArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitenDatentypen.EinheitenID'Range) of Sf.Graphics.sfTexture_Ptr;
   EinheitenAccess : EinheitenAccesArray := (others => (others => null));

   type GebäudeAccessArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, StadtDatentypen.GebäudeID'Range) of Sf.Graphics.sfTexture_Ptr;
   GebäudeAccess : GebäudeAccessArray := (others => (others => null));

end EingeleseneTexturenGrafik;

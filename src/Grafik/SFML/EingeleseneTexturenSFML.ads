pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;

with StadtDatentypen;
with EinheitenDatentypen;
with MenueDatentypen;
with KartenVerbesserungDatentypen;
with RassenDatentypen;

with KartengrundDatenbank;
with KartenflussDatenbank;
with KartenressourcenDatenbank;

package EingeleseneTexturenSFML is

   ---------------- Eventuell nach Bereiche aufteilen, damit dass hier nicht zu unübersichtlich wird?
   ---------------- Wenn dann in die gleichen Bereiche wie in EinlesenTexturen.

   type MenüHintergrundAccessArray is array (MenueDatentypen.Welches_Menü_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   MenüHintergrundAccess : MenüHintergrundAccessArray := (others => null);

   type KartenfelderAccessArray is array (KartengrundDatenbank.KartengrundlisteArray'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenfelderAccess : KartenfelderAccessArray := (others => null);

   type KartenflussAccessArray is array (KartenflussDatenbank.KartenflusslisteArray'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenflussAccess : KartenflussAccessArray := (others => null);

   type KartenressourcenAccessArray is array (KartenressourcenDatenbank.KartenRessourcenListeArray'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenressourceAccess : KartenressourcenAccessArray := (others => null);

   type VerbesserungenAccessArray is array (KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   VerbesserungenAccess : VerbesserungenAccessArray := (others => null);

   type WegeAccessArray is array (KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   WegeAccess : WegeAccessArray := (others => null);

   type EinheitenAccesArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitenDatentypen.EinheitenID'Range) of Sf.Graphics.sfTexture_Ptr;
   EinheitenAccess : EinheitenAccesArray := (others => (others => null));

   type GebäudeAccessArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, StadtDatentypen.GebäudeID'Range) of Sf.Graphics.sfTexture_Ptr;
   GebäudeAccess : GebäudeAccessArray := (others => (others => null));

end EingeleseneTexturenSFML;

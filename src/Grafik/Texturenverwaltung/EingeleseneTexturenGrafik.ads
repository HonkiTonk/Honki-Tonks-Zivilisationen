with Sf.Graphics;

with StadtDatentypen;
with EinheitenDatentypen;
with KartenverbesserungDatentypen;
with SpeziesDatentypen;
with GrafikDatentypen;
with BefehleDatentypen;
with KartenDatenbank;
with KartenextraDatentypen;

package EingeleseneTexturenGrafik is
   pragma Elaborate_Body;

   BasisgrundAccess : Sf.Graphics.sfTexture_Ptr := null;


   ZusatzgrundAccessGesamt : Sf.Graphics.sfTexture_Ptr := null;
   KartenflussAccessGesamt : Sf.Graphics.sfTexture_Ptr := null;
   KartenressourcenAccessGesamt : Sf.Graphics.sfTexture_Ptr := null;
   -- Auch auf Spezies erweitern, damit man verschieden aussehende Städte/Verbesserungen hat? äöü
   VerbesserungenAccessGesamt : Sf.Graphics.sfTexture_Ptr := null;
   WegeAccessGesamt : Sf.Graphics.sfTexture_Ptr := null;
   FeldeffekteAccessGesamt : Sf.Graphics.sfTexture_Ptr := null;

   EinheitenbefehleAccess : Sf.Graphics.sfTexture_Ptr := null;
   KartenbefehleAccess : Sf.Graphics.sfTexture_Ptr := null;
   RoterKnopfAccess : Sf.Graphics.sfTexture_Ptr := null;
   IntroAccess : Sf.Graphics.sfTexture_Ptr := null;
   KartenformenAccess : Sf.Graphics.sfTexture_Ptr := null;
   SeitenleisteAccess : Sf.Graphics.sfTexture_Ptr := null;
   MenüsAccess : Sf.Graphics.sfTexture_Ptr := null;
   PZBEndeAccess : Sf.Graphics.sfTexture_Ptr := null;
   AuswahlAccess : Sf.Graphics.sfTexture_Ptr := null;
   MeldungAccess : Sf.Graphics.sfTexture_Ptr := null;

   type SpeziesAccessArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   EinheitenAccessGesamt : SpeziesAccessArray := (others => null);
   GebäudeAccessGesamt : SpeziesAccessArray := (others => null);
   HintergrundAccessGesamt : SpeziesAccessArray := (others => null);



   type SystemAccessArray is array (BefehleDatentypen.Befehlsknöpfe_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   SystemAccess : SystemAccessArray := (others => null);

   type HintergrundAccessArray is array (GrafikDatentypen.Hintergrund_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   HintergrundAccess : HintergrundAccessArray := (others => null);

   type ZusatzgrundAccessArray is array (KartenDatenbank.ZusatzgrundlisteArray'Range) of Sf.Graphics.sfTexture_Ptr;
   ZusatzgrundAccess : ZusatzgrundAccessArray := (others => null);

   type FeldeffekteAccessArray is array (KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   FeldeffekteAccess : FeldeffekteAccessArray := (others => null);

   type KartenflussAccessArray is array (KartenDatenbank.KartenflusslisteArray'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenflussAccess : KartenflussAccessArray := (others => null);

   type KartenressourcenAccessArray is array (KartenDatenbank.KartenressourcenlisteArray'Range) of Sf.Graphics.sfTexture_Ptr;
   KartenressourceAccess : KartenressourcenAccessArray := (others => null);

   type VerbesserungenAccessArray is array (KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   VerbesserungenAccess : VerbesserungenAccessArray := (others => null);

   type WegeAccessArray is array (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   WegeAccess : WegeAccessArray := (others => null);

   type SpezieshintergrundAccessArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   SpezieshintergrundAccess : SpezieshintergrundAccessArray := (others => (others => null));

   type EinheitenAccesArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, EinheitenDatentypen.EinheitenIDVorhanden'Range) of Sf.Graphics.sfTexture_Ptr;
   EinheitenAccess : EinheitenAccesArray := (others => (others => null));

   type GebäudeAccessArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, StadtDatentypen.GebäudeIDVorhanden'Range) of Sf.Graphics.sfTexture_Ptr;
   GebäudeAccess : GebäudeAccessArray := (others => (others => null));

end EingeleseneTexturenGrafik;

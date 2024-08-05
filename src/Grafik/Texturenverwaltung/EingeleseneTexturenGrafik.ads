with Sf.Graphics;

with SpeziesDatentypen;
with GrafikDatentypen;

package EingeleseneTexturenGrafik is
   pragma Elaborate_Body;

   BasisgrundAccess : Sf.Graphics.sfTexture_Ptr := null;
   ZusatzgrundAccess : Sf.Graphics.sfTexture_Ptr := null;

   FlussAccess : Sf.Graphics.sfTexture_Ptr := null;
   RessourcenAccess : Sf.Graphics.sfTexture_Ptr := null;
   -- Auch auf Spezies erweitern, damit man verschieden aussehende Städte/Verbesserungen hat? äöü
   VerbesserungenAccess : Sf.Graphics.sfTexture_Ptr := null;
   WegeAccess : Sf.Graphics.sfTexture_Ptr := null;
   FeldeffekteAccess : Sf.Graphics.sfTexture_Ptr := null;

   IntroAccess : Sf.Graphics.sfTexture_Ptr := null;
   AllgemeinesAccess : Sf.Graphics.sfTexture_Ptr := null;
   KartenbefehleAccess : Sf.Graphics.sfTexture_Ptr := null;
   EinheitenbefehleAccess : Sf.Graphics.sfTexture_Ptr := null;
   KartenformenAccess : Sf.Graphics.sfTexture_Ptr := null;


   AuswahlAccess : Sf.Graphics.sfTexture_Ptr := null;


   RoterKnopfAccess : Sf.Graphics.sfTexture_Ptr := null;
   SeitenleisteAccess : Sf.Graphics.sfTexture_Ptr := null;
   PZBEndeAccess : Sf.Graphics.sfTexture_Ptr := null;
   MeldungAccess : Sf.Graphics.sfTexture_Ptr := null;

   type SpeziesAccessArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   EinheitenAccess : SpeziesAccessArray := (others => null);
   GebäudeAccess : SpeziesAccessArray := (others => null);
   HintergrundAccessGesamt : SpeziesAccessArray := (others => null);



   type HintergrundAccessArray is array (GrafikDatentypen.Hintergrund_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   HintergrundAccess : HintergrundAccessArray := (others => null);

   type SpezieshintergrundAccessArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum'Range) of Sf.Graphics.sfTexture_Ptr;
   SpezieshintergrundAccess : SpezieshintergrundAccessArray := (others => (others => null));

end EingeleseneTexturenGrafik;

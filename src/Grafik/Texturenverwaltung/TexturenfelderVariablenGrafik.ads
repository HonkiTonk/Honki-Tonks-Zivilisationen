with Sf.Graphics.Rect;
with Sf.System.Vector2;

with KartengrundDatentypen;
with KartenextraDatentypen;
with KartenverbesserungDatentypen;
with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtDatentypen;
with GrafikDatentypen;

package TexturenfelderVariablenGrafik is
   pragma Elaborate_Body;

   -- Das mit EingeleseneTexturen zusammenführen? äöü
   type BasisgrundArray is array (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Basisgrund : BasisgrundArray;
   
   type ZusatzgrundArray is array (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Zusatzgrund : ZusatzgrundArray;
   
   type FlüsseArray is array (KartenextraDatentypen.Fluss_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Flüsse : FlüsseArray;
   
   type RessourcenArray is array (KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Ressourcen : RessourcenArray;
   
   type VerbesserungenArray is array (KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Verbesserungen : VerbesserungenArray;
   
   type WegeArray is array (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Wege : WegeArray;
   
   type FeldeffekteArray is array (KartenextraDatentypen.Effekt_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Feldeffekte : FeldeffekteArray;
   
   
   
   type HintergründeArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Hintergründe : HintergründeArray;
   
   type EinheitenArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, EinheitenDatentypen.EinheitenIDVorhanden'Range) of Sf.Graphics.Rect.sfIntRect;
   Einheiten : EinheitenArray;
   
   type GebäudeArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, StadtDatentypen.GebäudeIDVorhanden'Range) of Sf.Graphics.Rect.sfIntRect;
   Gebäude : GebäudeArray;
   
   type IntroArray is array (GrafikDatentypen.Hintergrund_Intro_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Intro : IntroArray;
   
   
   
   function Basisgrundbereich
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  Basisgrundbereich'Result.left >= 0
                and
                  Basisgrundbereich'Result.top >= 0
                and
                  Basisgrundbereich'Result.width >= 0
                and
                  Basisgrundbereich'Result.height >= 0
               );
   
   function Basisgrundabmessung
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Basisgrundabmessung'Result.x >= 0.00
                and
                  Basisgrundabmessung'Result.y >= 0.00
               );
   
   function Zusatzgrundbereich
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  Zusatzgrundbereich'Result.left >= 0
                and
                  Zusatzgrundbereich'Result.top >= 0
                and
                  Zusatzgrundbereich'Result.width >= 0
                and
                  Zusatzgrundbereich'Result.height >= 0
               );
   
   function Zusatzgrundabmessung
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Zusatzgrundabmessung'Result.x >= 0.00
                and
                  Zusatzgrundabmessung'Result.y >= 0.00
               );
   
   function Flussbereich
     (FlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  Flussbereich'Result.left >= 0
                and
                  Flussbereich'Result.top >= 0
                and
                  Flussbereich'Result.width >= 0
                and
                  Flussbereich'Result.height >= 0
               );
   
   function Flussabmessung
     (FlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Flussabmessung'Result.x >= 0.00
                and
                  Flussabmessung'Result.y >= 0.00
               );
   
   function Ressourcenbereich
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  Ressourcenbereich'Result.left >= 0
                and
                  Ressourcenbereich'Result.top >= 0
                and
                  Ressourcenbereich'Result.width >= 0
                and
                  Ressourcenbereich'Result.height >= 0
               );
   
   function Ressourcenabmessung
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Ressourcenabmessung'Result.x >= 0.00
                and
                  Ressourcenabmessung'Result.y >= 0.00
               );
   
   function Verbesserungsbereich
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  Verbesserungsbereich'Result.left >= 0
                and
                  Verbesserungsbereich'Result.top >= 0
                and
                  Verbesserungsbereich'Result.width >= 0
                and
                  Verbesserungsbereich'Result.height >= 0
               );
   
   function Verbesserungsabmessung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Verbesserungsabmessung'Result.x >= 0.00
                and
                  Verbesserungsabmessung'Result.y >= 0.00
               );
   
   function Wegebereich
     (WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  Wegebereich'Result.left >= 0
                and
                  Wegebereich'Result.top >= 0
                and
                  Wegebereich'Result.width >= 0
                and
                  Wegebereich'Result.height >= 0
               );
   
   function Wegeabmessung
     (WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Wegeabmessung'Result.x >= 0.00
                and
                  Wegeabmessung'Result.y >= 0.00
               );
   
   function Feldeffektebereich
     (FeldeffektedExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  Feldeffektebereich'Result.left >= 0
                and
                  Feldeffektebereich'Result.top >= 0
                and
                  Feldeffektebereich'Result.width >= 0
                and
                  Feldeffektebereich'Result.height >= 0
               );
   
   function Feldeffekteabmessung
     (FeldeffektedExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Feldeffekteabmessung'Result.x >= 0.00
                and
                  Feldeffekteabmessung'Result.y >= 0.00
               );
   
   function Hintergrundbereich
     (HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  Hintergrundbereich'Result.left >= 0
                and
                  Hintergrundbereich'Result.top >= 0
                and
                  Hintergrundbereich'Result.width >= 0
                and
                  Hintergrundbereich'Result.height >= 0
               );
   
   function Hintergrundabmessung
     (HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Hintergrundabmessung'Result.x >= 0.00
                and
                  Hintergrundabmessung'Result.y >= 0.00
               );
   
   function Einheitenbereich
     (EinheitExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  Einheitenbereich'Result.left >= 0
                and
                  Einheitenbereich'Result.top >= 0
                and
                  Einheitenbereich'Result.width >= 0
                and
                  Einheitenbereich'Result.height >= 0
               );
   
   function Einheitenabmessung
     (EinheitExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Einheitenabmessung'Result.x >= 0.00
                and
                  Einheitenabmessung'Result.y >= 0.00
               );
   
   function Gebäudebereich
     (GebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  Gebäudebereich'Result.left >= 0
                and
                  Gebäudebereich'Result.top >= 0
                and
                  Gebäudebereich'Result.width >= 0
                and
                  Gebäudebereich'Result.height >= 0
               );
   
   function Gebäudeabmessung
     (GebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Gebäudeabmessung'Result.x >= 0.00
                and
                  Gebäudeabmessung'Result.y >= 0.00
               );
         
   function Introbereich
     (IntroExtern : in GrafikDatentypen.Hintergrund_Intro_Enum)
      return Sf.Graphics.Rect.sfIntRect;
   
   function Introabmessung
     (IntroExtern : in GrafikDatentypen.Hintergrund_Intro_Enum)
      return Sf.System.Vector2.sfVector2f;

end TexturenfelderVariablenGrafik;

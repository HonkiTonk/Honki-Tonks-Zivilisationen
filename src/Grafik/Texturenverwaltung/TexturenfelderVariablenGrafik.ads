with Sf.Graphics.Rect;
with Sf.System.Vector2;

with KartengrundDatentypen;
with KartenextraDatentypen;
with KartenverbesserungDatentypen;
with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtDatentypen;
with GrafikDatentypen;
with TastenbelegungDatentypen;
with BefehleDatentypen;

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
   
   type AllgemeinesArray is array (GrafikDatentypen.Hintergrund_Allgemein_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Allgemeines : AllgemeinesArray;
   
   type KartenbefehleArray is array (TastenbelegungDatentypen.Kartenbefehle_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Kartenbefehle : KartenbefehleArray;
   
   type EinheitenbefehleArray is array (BefehleDatentypen.Einheiten_Aufgaben_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Einheitenbefehle : EinheitenbefehleArray;
   
   type KartenformenArray is array (GrafikDatentypen.Hintergrund_Kartenformen_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Kartenformen : KartenformenArray;
   
   Auswahl : Sf.Graphics.Rect.sfIntRect;
   
   
   
   function BasisgrundRechteck
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  BasisgrundRechteck'Result.left >= 0
                and
                  BasisgrundRechteck'Result.top >= 0
                and
                  BasisgrundRechteck'Result.width >= 0
                and
                  BasisgrundRechteck'Result.height >= 0
               );
   
   function BasisgrundVektor
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  BasisgrundVektor'Result.x >= 0.00
                and
                  BasisgrundVektor'Result.y >= 0.00
               );
   
   function ZusatzgrundRechteck
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  ZusatzgrundRechteck'Result.left >= 0
                and
                  ZusatzgrundRechteck'Result.top >= 0
                and
                  ZusatzgrundRechteck'Result.width >= 0
                and
                  ZusatzgrundRechteck'Result.height >= 0
               );
   
   function ZusatzgrundVektor
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  ZusatzgrundVektor'Result.x >= 0.00
                and
                  ZusatzgrundVektor'Result.y >= 0.00
               );
   
   function FlussRechteck
     (FlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  FlussRechteck'Result.left >= 0
                and
                  FlussRechteck'Result.top >= 0
                and
                  FlussRechteck'Result.width >= 0
                and
                  FlussRechteck'Result.height >= 0
               );
   
   function FlussVektor
     (FlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  FlussVektor'Result.x >= 0.00
                and
                  FlussVektor'Result.y >= 0.00
               );
   
   function RessourcenRechteck
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  RessourcenRechteck'Result.left >= 0
                and
                  RessourcenRechteck'Result.top >= 0
                and
                  RessourcenRechteck'Result.width >= 0
                and
                  RessourcenRechteck'Result.height >= 0
               );
   
   function RessourcenVektor
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  RessourcenVektor'Result.x >= 0.00
                and
                  RessourcenVektor'Result.y >= 0.00
               );
   
   function VerbesserungRechteck
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  VerbesserungRechteck'Result.left >= 0
                and
                  VerbesserungRechteck'Result.top >= 0
                and
                  VerbesserungRechteck'Result.width >= 0
                and
                  VerbesserungRechteck'Result.height >= 0
               );
   
   function VerbesserungVektor
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  VerbesserungVektor'Result.x >= 0.00
                and
                  VerbesserungVektor'Result.y >= 0.00
               );
   
   function WegeRechteck
     (WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  WegeRechteck'Result.left >= 0
                and
                  WegeRechteck'Result.top >= 0
                and
                  WegeRechteck'Result.width >= 0
                and
                  WegeRechteck'Result.height >= 0
               );
   
   function WegeVektor
     (WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  WegeVektor'Result.x >= 0.00
                and
                  WegeVektor'Result.y >= 0.00
               );
   
   function FeldeffekteRechteck
     (FeldeffektedExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  FeldeffekteRechteck'Result.left >= 0
                and
                  FeldeffekteRechteck'Result.top >= 0
                and
                  FeldeffekteRechteck'Result.width >= 0
                and
                  FeldeffekteRechteck'Result.height >= 0
               );
   
   function FeldeffekteVektor
     (FeldeffektedExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  FeldeffekteVektor'Result.x >= 0.00
                and
                  FeldeffekteVektor'Result.y >= 0.00
               );
   
   function HintergrundRechteck
     (HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  HintergrundRechteck'Result.left >= 0
                and
                  HintergrundRechteck'Result.top >= 0
                and
                  HintergrundRechteck'Result.width >= 0
                and
                  HintergrundRechteck'Result.height >= 0
               );
   
   function HintergrundVektor
     (HintergrundExtern : in GrafikDatentypen.Spezieshintergrund_Vorhanden_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  HintergrundVektor'Result.x >= 0.00
                and
                  HintergrundVektor'Result.y >= 0.00
               );
   
   function EinheitenRechteck
     (EinheitExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  EinheitenRechteck'Result.left >= 0
                and
                  EinheitenRechteck'Result.top >= 0
                and
                  EinheitenRechteck'Result.width >= 0
                and
                  EinheitenRechteck'Result.height >= 0
               );
   
   function EinheitenVektor
     (EinheitExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  EinheitenVektor'Result.x >= 0.00
                and
                  EinheitenVektor'Result.y >= 0.00
               );
   
   function GebäudeRechteck
     (GebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  GebäudeRechteck'Result.left >= 0
                and
                  GebäudeRechteck'Result.top >= 0
                and
                  GebäudeRechteck'Result.width >= 0
                and
                  GebäudeRechteck'Result.height >= 0
               );
   
   function GebäudeVektor
     (GebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  GebäudeVektor'Result.x >= 0.00
                and
                  GebäudeVektor'Result.y >= 0.00
               );
   
   function HintergrundRechteck
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Gesamt_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  HintergrundRechteck'Result.left >= 0
                and
                  HintergrundRechteck'Result.top >= 0
                and
                  HintergrundRechteck'Result.width >= 0
                and
                  HintergrundRechteck'Result.height >= 0
               );
   
   function HintergrundVektor
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Gesamt_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  HintergrundVektor'Result.x >= 0.00
                and
                  HintergrundVektor'Result.y >= 0.00
               );
   
   function KartenbefehleRechteck
     (BefehlExtern : in TastenbelegungDatentypen.Kartenbefehle_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  KartenbefehleRechteck'Result.left >= 0
                and
                  KartenbefehleRechteck'Result.top >= 0
                and
                  KartenbefehleRechteck'Result.width >= 0
                and
                  KartenbefehleRechteck'Result.height >= 0
               );
   
   function KartenbefehleVektor
     (BefehlExtern : in TastenbelegungDatentypen.Kartenbefehle_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  KartenbefehleVektor'Result.x >= 0.00
                and
                  KartenbefehleVektor'Result.y >= 0.00
               );
   
   function EinheitenbefehleRechteck
     (BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Enum)
      return Sf.Graphics.Rect.sfIntRect
     with
       Post => (
                  EinheitenbefehleRechteck'Result.left >= 0
                and
                  EinheitenbefehleRechteck'Result.top >= 0
                and
                  EinheitenbefehleRechteck'Result.width >= 0
                and
                  EinheitenbefehleRechteck'Result.height >= 0
               );
         
   function EinheitenbefehleVektor
     (BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  EinheitenbefehleVektor'Result.x >= 0.00
                and
                  EinheitenbefehleVektor'Result.y >= 0.00
               );
   
private
   
   Zwischenspeicher : Sf.System.Vector2.sfVector2f;

end TexturenfelderVariablenGrafik;

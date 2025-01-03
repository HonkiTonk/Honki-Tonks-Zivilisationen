with Sf.System.Vector2;
with Sf.Graphics.Rect;

with StadtDatentypen;

package Vergleiche is
   pragma Elaborate_Body;
   use type StadtDatentypen.Einwohner;
   
   function Auswahlposition
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      RechteckExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Boolean;
   
   function AuswahlpositionVereinfacht
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      VektorExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean;
   
   generic type GanzeZahl is range <>;
   
   function Achsenauswahlposition
     (MausachseExtern : in Float;
      BasiswertExtern : in Float;
      AnfangswertExtern : in GanzeZahl;
      EndwertExtern : in GanzeZahl)
      return GanzeZahl;
   
   function FreieEinwohner
     (EinwohnerExtern : in StadtDatentypen.Einwohner;
      ArbeiterExtern : in StadtDatentypen.Einwohner)
      return StadtDatentypen.Einwohner
    with
      Pre => (
                EinwohnerExtern >= ArbeiterExtern
             );

end Vergleiche;

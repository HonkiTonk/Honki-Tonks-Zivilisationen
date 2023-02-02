with Sf.System.Vector2;
with Sf.Graphics.Rect;

package Vergleiche is
   pragma Elaborate_Body;
   
   function Auswahlposition
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      TextboxExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Boolean;
   
   generic type GanzeZahl is range <>;
   
   function Achsenauswahlposition
     (MausachseExtern : in Float;
      BasiswertExtern : in Float;
      AnfangswertExtern : in GanzeZahl;
      EndwertExtern : in GanzeZahl)
      return GanzeZahl;

end Vergleiche;

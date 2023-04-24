with Sf.System.Vector2;
with Sf.Graphics.Rect;

package Vergleiche is
   pragma Elaborate_Body;
   
   -- TextboxExtern mal durch einen besseren Namen ersetzen. äöü
   function Auswahlposition
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      TextboxExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Boolean;
   
   function AuswahlpositionVereinfacht
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      TextboxExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean;
   
   generic type GanzeZahl is range <>;
   
   function Achsenauswahlposition
     (MausachseExtern : in Float;
      BasiswertExtern : in Float;
      AnfangswertExtern : in GanzeZahl;
      EndwertExtern : in GanzeZahl)
      return GanzeZahl;

end Vergleiche;

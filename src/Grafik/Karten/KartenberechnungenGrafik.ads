pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics.Rect;

package KartenberechnungenGrafik is
   -- pragma Elaborate_Body; äöü
   
   -- Das hier über eine Funktion abrufen? äöü
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   StadtfelderAbmessung : Sf.System.Vector2.sfVector2f;
   
   FensterKarte : Sf.Graphics.Rect.sfFloatRect;
   StadtKarte : Sf.Graphics.Rect.sfFloatRect;
   
   procedure KartenfelderAbmessungBerechnen;
   procedure StadtfelderAbmessungBerechnen;

end KartenberechnungenGrafik;

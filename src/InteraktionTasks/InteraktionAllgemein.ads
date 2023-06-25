with Sf.System.Vector2;

package InteraktionAllgemein is
   pragma Elaborate_Body;
   
   -- Mausposition wird immer vom Grafiktask geschrieben und aktuell vom Logik- und Grafiktask gelesen, sollte auch so bleiben.
   Mausposition : Sf.System.Vector2.sfVector2f;

end InteraktionAllgemein;

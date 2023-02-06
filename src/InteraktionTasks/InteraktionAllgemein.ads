with Sf.System.Vector2;

package InteraktionAllgemein is
   pragma Elaborate_Body;
   
   -- Diesen Wert hier immer im Grafiktask neu festlegen lassen, da die Verwendung der A/SFML Funktion im Logiktask zu Abstürzen führen kann.
   -- Ist das überhaupt korrekt oder lag das Problem woanders? äöü
   -- Ist das noch wichtig? äöü
   -- Mausposition wird immer vom Grafiktask geschrieben und aktuell vom Logik- und Grafiktask gelesen, sollte auch so bleiben.
   Mausposition : Sf.System.Vector2.sfVector2f;

end InteraktionAllgemein;

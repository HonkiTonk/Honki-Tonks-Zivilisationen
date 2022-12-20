with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;

package Befehlstexte is
   pragma Elaborate_Body;

   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   
   -- Die Stadt und Kartenbefehle getrennt voneinander oder zusammen? äöü
   Stadtbefehle : TexteArray (1 .. 6) := (others => TextKonstanten.FehlenderText);

end Befehlstexte;

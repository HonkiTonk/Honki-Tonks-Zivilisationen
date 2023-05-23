with TextKonstanten;
with TextArrays;

package Befehlstexte is
   pragma Elaborate_Body;

   -- Die Stadt und Kartenbefehle getrennt voneinander oder zusammen? äöü
   Stadtbefehle : TextArrays.AllgemeinesTextArray (1 .. 6) := (others => TextKonstanten.FehlenderText);

end Befehlstexte;

with TextKonstanten;
with TextArrays;

package Befehlstexte is
   pragma Elaborate_Body;

   Stadtbefehle : TextArrays.AllgemeinesTextArray (1 .. 6) := (others => TextKonstanten.FehlenderText);

   StadtbefehleLängstes : TextArrays.AllgemeinesTextArray (Stadtbefehle'Range) := (others => TextKonstanten.FehlenderText);

end Befehlstexte;

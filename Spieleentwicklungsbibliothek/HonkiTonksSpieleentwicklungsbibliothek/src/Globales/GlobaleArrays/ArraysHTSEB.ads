with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package ArraysHTSEB is
   pragma Preelaborate;

   type AllgemeinesTextArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   -- type NullTextArray is array (Natural range <>) of Unbounded_Wide_Wide_String;

   type SetsArray is array (1 .. 11) of Unbounded_Wide_Wide_String;

   SetsEinlesen : ArraysHTSEB.AllgemeinesTextArray (1 .. 100);

end ArraysHTSEB;

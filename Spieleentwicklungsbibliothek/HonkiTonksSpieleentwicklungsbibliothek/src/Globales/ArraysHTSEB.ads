with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package ArraysHTSEB is
   pragma Preelaborate;

   type AllgemeinesTextArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   -- type NullTextArray is array (Natural range <>) of Unbounded_Wide_Wide_String;

end ArraysHTSEB;

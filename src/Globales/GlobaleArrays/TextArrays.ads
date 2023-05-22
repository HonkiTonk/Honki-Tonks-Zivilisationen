with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package TextArrays is
   pragma Preelaborate;

   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;

end TextArrays;

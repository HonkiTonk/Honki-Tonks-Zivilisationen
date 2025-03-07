with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ArraysHTSEB;

package TextArrays is
   pragma Preelaborate;

   type SpielstandArray is array (1 .. 11) of Unbounded_Wide_Wide_String;

   type SetsArray is array (1 .. 11) of Unbounded_Wide_Wide_String;

   SetsEinlesen : ArraysHTSEB.AllgemeinesTextArray (1 .. 100);

end TextArrays;

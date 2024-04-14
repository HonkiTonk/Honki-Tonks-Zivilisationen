with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package TextArrays is
   pragma Preelaborate;

   type AllgemeinesTextArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   -- type NullTextArray is array (Natural range <>) of Unbounded_Wide_Wide_String;

   type SpielstandArray is array (1 .. 11) of Unbounded_Wide_Wide_String;

   type SprachenArray is array (1 .. 11) of Unbounded_Wide_Wide_String;

   -- Solche Sachen die in mehreren Datei gebraucht werden mal in einer Datei zusammenfassen? äöü
   SprachenEinlesen : AllgemeinesTextArray (1 .. 100);

end TextArrays;

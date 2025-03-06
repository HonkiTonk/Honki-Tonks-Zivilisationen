with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package TextArrays is
   pragma Preelaborate;

   -- Das hier noch durch die Bibliotheksvariante ersetzen. äöü
   type AllgemeinesTextArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   -- type NullTextArray is array (Natural range <>) of Unbounded_Wide_Wide_String;

   type SpielstandArray is array (1 .. 11) of Unbounded_Wide_Wide_String;

   type SprachenArray is array (1 .. 11) of Unbounded_Wide_Wide_String;

   type SetsArray is array (1 .. 11) of Unbounded_Wide_Wide_String;

   -- Solche Sachen die in mehreren Datei gebraucht werden mal in einer Datei zusammenfassen? äöü
   SprachenTexturenEinlesen : AllgemeinesTextArray (1 .. 100);

   SetsEinlesen : AllgemeinesTextArray (1 .. 100);

end TextArrays;

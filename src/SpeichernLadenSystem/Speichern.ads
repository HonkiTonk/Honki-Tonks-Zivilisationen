with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Directories, Karten, GlobaleVariablen, Eingabe;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Directories;

package Speichern is

   procedure AutoSpeichern;

   function Speichern return Boolean;

private

   SpielstandName : Unbounded_Wide_Wide_String;

   Datei : File_Type;

end Speichern;

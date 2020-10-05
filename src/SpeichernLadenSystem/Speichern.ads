with Ada.Wide_Wide_Text_IO, Karten, GlobaleVariablen;
use Ada.Wide_Wide_Text_IO;

package Speichern is

   procedure AutoSpeichern;

   function Speichern return Boolean;

private

   Datei : File_Type;

end Speichern;

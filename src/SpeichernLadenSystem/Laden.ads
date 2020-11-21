with Ada.Wide_Wide_Text_IO, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories;

with Karten, GlobaleVariablen, Eingabe, AllesAufAnfangSetzen;

package Laden is

   procedure Laden;

private

   Zeilenanzahl : Integer;
   KartenPlusWert : Integer;
   Zwischenwert : Integer;

   SpielstandName : Unbounded_Wide_Wide_String;

   Datei : File_Type;
   DateiWide : Ada.Wide_Wide_Text_IO.File_Type;

end Laden;

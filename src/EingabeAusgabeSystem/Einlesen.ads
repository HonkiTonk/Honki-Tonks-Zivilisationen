with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Strings.Unbounded, Ada.Directories, Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Strings.Unbounded, Ada.Directories, Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Text_IO;

with GlobaleVariablen, KartenDatenbank, VerbesserungenDatenbank, GebaeudeDatenbank, ForschungsDatenbank, EinheitenDatenbank;

package Einlesen is

   function Einlesen return Boolean;

private

   Erfolgreich : Boolean;

   type WelcheTexteEinlesenArray is array (GlobaleVariablen.TexteEinlesen'Range (1)) of Unbounded_String;
   WelcheTexteEinlesen : WelcheTexteEinlesenArray;

   type WelcheWerteEinlesenArray is array (1 .. 5) of Unbounded_String;
   WelcheWerteEinlesen : WelcheWerteEinlesenArray;

   DateiWelcheTexteEinlesen : Ada.Text_IO.File_Type;
   DateiWelcheWerteEinlesen : Ada.Text_IO.File_Type;
   DateiText : Ada.Wide_Wide_Text_IO.File_Type;
   DateiWerte : Ada.Wide_Wide_Text_IO.File_Type;

   procedure EinlesenWerte;

   function EinlesenText return Boolean;

end Einlesen;

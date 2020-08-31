with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Strings.Unbounded, Ada.Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Strings.Unbounded, Ada.Text_IO;

package Einlesen is

   type TexteEinlesenArray is array (1 .. 21, 1 .. 50) of Unbounded_Wide_Wide_String;
   TexteEinlesen : TexteEinlesenArray := (others => (others => (To_Unbounded_Wide_Wide_String ("|"))));


   -- type GanzeZahlenEinlesenArray is array (1 .. 1, 1 .. 10

   procedure EinlesenText;
   procedure EinlesenGanzeZahl;
   -- procedure EinlesenKommazahl;

private

   type WelcheTexteEinlesenArray is array (TexteEinlesen'Range (1)) of Unbounded_String;
   WelcheTexteEinlesen : WelcheTexteEinlesenArray;

   DateiWelcheTexteEinlesen : Ada.Text_IO.File_Type;
   DateiText : Ada.Wide_Wide_Text_IO.File_Type;

end Einlesen;

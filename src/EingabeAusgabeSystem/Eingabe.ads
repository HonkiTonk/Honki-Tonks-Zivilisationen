with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling;

with GlobaleVariablen, Anzeige;

package Eingabe is

   function GanzeZahl (Zahlengröße : Integer) return Integer;
   function StadtName return Unbounded_Wide_Wide_String;
   function SpielstandName return Unbounded_Wide_Wide_String;

private

   Name : Unbounded_Wide_Wide_String;
   Zahl : Unbounded_Wide_Wide_String;

end Eingabe;

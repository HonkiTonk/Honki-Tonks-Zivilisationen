with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package Eingabe is

   Zahl : Unbounded_Wide_Wide_String;

   function GanzeZahl return Integer;
   function StadtName return Unbounded_Wide_Wide_String;

private

   Name : Unbounded_Wide_Wide_String;

end Eingabe;

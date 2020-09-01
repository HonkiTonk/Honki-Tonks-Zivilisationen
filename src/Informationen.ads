with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

package Informationen is

   procedure Informationen;

private

   Taste : Wide_Wide_Character;
   Versionsnummer : Wide_Wide_String (1 .. 9) := "0.00.5250";

end Informationen;

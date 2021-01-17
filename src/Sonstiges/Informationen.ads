with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

package Informationen is

   procedure Informationen;

private

   Taste : Wide_Wide_Character;
   Versionsnummer : Wide_Wide_String (1 .. 9) := "0.00.6140";

end Informationen;

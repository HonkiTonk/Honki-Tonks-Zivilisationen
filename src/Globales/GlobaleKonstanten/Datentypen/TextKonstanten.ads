pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_1;

package TextKonstanten is

   FehlenderText : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => " |ÄÖÜ Hier wurde kein Text eingelesen ÜÖÄ| ");
   
   LeerString : constant Wide_Wide_String := "";
   LeerUnboundedString : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => LeerString);
   Trennzeichen : constant Wide_Wide_String (1 .. 1) := "/";
   TrennzeichenUnterschiedlich : constant Wide_Wide_String (1 .. 1) := "|";
   StandardAbstand : constant Wide_Wide_String (1 .. 4) := "    ";
   LangerAbstand : constant Wide_Wide_String (1 .. 10) := "          ";
   UmbruchAbstand : constant Wide_Wide_String (1 .. 5) := Ada.Characters.Wide_Wide_Latin_1.LF & StandardAbstand;
   
end TextKonstanten;

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_1;

package TextKonstanten is
   pragma Elaborate_Body;

   LeerString : constant Wide_Wide_String := "";
   Leerzeichen : constant Wide_Wide_String (1 .. 1) := " ";
   Trennzeichen : constant Wide_Wide_String (1 .. 1) := "/";
   TrennzeichenUnterschiedlich : constant Wide_Wide_String (1 .. 1) := "|";
   StandardAbstand : constant Wide_Wide_String (1 .. 4) := "    ";
   LangerAbstand : constant Wide_Wide_String (1 .. 10) := "          ";
   UmbruchAbstand : constant Wide_Wide_String (1 .. 5) := Ada.Characters.Wide_Wide_Latin_1.LF & StandardAbstand;
   
   FehlenderText : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => "ÄÖÜ Hier wurde kein Text eingelesen ÜÖÄ");
   LeerUnboundedString : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => LeerString);
   LeerzeichenUnboundedString : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => Leerzeichen);
   
end TextKonstanten;

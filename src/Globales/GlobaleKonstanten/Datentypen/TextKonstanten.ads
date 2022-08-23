pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_1;

with Sf.System.Vector2;

package TextKonstanten is
   
   LeerString : constant Wide_Wide_String := "";
   LeerUnboundedString : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => LeerString);
   LeerZeichen : constant Wide_Wide_Character := ' ';
   Trennzeichen : constant Wide_Wide_String (1 .. 1) := "/";
   StandardAbstand : constant Wide_Wide_String (1 .. 4) := "    ";
   UmbruchAbstand : constant Wide_Wide_String (1 .. 5) := Ada.Characters.Wide_Wide_Latin_1.LF & StandardAbstand;
   
   -- Überall entsprechend einbauen. äöü
   StartpositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   
   TextbreiteZusatzwert : constant Float := StartpositionText.x * 5.00;
   TexthöheZusatzwert : constant Float := StartpositionText.y * 3.00;
   LeerTextbreite : constant Float := 0.00;

end TextKonstanten;

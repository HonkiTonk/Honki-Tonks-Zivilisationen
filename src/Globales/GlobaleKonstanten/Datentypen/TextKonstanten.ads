with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with BetriebssystemKonstantenHTSEB;

-- Das mal teilweise oder ganz auslagern? äöü
package TextKonstanten is
   pragma Elaborate_Body;
   
   TrennzeichenUnterschiedlich : constant Wide_Wide_Character := '|';
   Trennzeichen : constant Wide_Wide_Character := '/';
   
   Trennstrich : constant Wide_Wide_String (1 .. 3) := " - ";
   StandardAbstand : constant Wide_Wide_String (1 .. 4) := "    ";
   LangerAbstand : constant Wide_Wide_String (1 .. 10) := "          ";
   UmbruchAbstand : constant Wide_Wide_String (1 .. 5) := BetriebssystemKonstantenHTSEB.LF & StandardAbstand;
   UnendlichGeklammert : constant Wide_Wide_String (1 .. 4) := " (∞)";
   Unendlich : constant Wide_Wide_String (1 .. 2) := " ∞";
   Haken : constant Wide_Wide_String (1 .. 2) := " ✔";
   Kreuz : constant Wide_Wide_String (1 .. 2) := " ✘";
   
   Standardtexturen : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => "Standard");
   Standardmusik : constant Unbounded_Wide_Wide_String := Standardtexturen;
   Stadnardsound : constant Unbounded_Wide_Wide_String := Standardtexturen;
   
end TextKonstanten;

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9, Anzeige, GlobaleVariablen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

package Auswahl is

   function Auswahl (WelcheAuswahl, WelcherText : in Integer) return Integer;

private

   Taste : Wide_Wide_Character;

   AktuelleAuswahl : Integer := 1;
   Ende : Integer := 1;
   
end Auswahl;

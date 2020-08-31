with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9, Einlesen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

package Auswahl is

   function Auswahl (WelcheAuswahl, WelcherText : in Integer) return Integer;
   procedure AnzeigeLangerText (WelcherText, WelcheZeile : in Integer);

private

   Rahmen : Boolean;

   Taste : Wide_Wide_Character;

   Text : Wide_Wide_String (1 .. 1000) := (others => ('|'));

   AktuelleAuswahl : Integer := 1;
   Ende : Integer := 1;
   LängsterText : Integer := 1;
   Wert : Integer;
   N : Integer;
   
   Teilung : Float;
   
   procedure Anzeige (WelcherText : in Integer);

end Auswahl;

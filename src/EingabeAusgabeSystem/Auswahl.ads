with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with Anzeige, GlobaleVariablen;

package Auswahl is

   function AuswahlSprache return Unbounded_Wide_Wide_String;
   function Auswahl (WelcheAuswahl, WelcherText : in Integer) return Integer;
   function AuswahlNeu (AuswahlOderAnzeige : in Boolean; FrageDatei, FrageZeile, TextDatei, ErsteZeile, LetzteZeile : in Integer) return Integer
     with Pre => FrageDatei >= 0 and FrageZeile >= 0 and TextDatei >= 0 and ErsteZeile >= 0 and LetzteZeile >= 0 and ErsteZeile <= LetzteZeile;

private

   Taste : Wide_Wide_Character;

   AktuelleAuswahl : Integer := 1;
   Ende : Integer := 1;
   
end Auswahl;

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with Anzeige, GlobaleVariablen;

package Auswahl is

   function AuswahlSprache return Unbounded_Wide_Wide_String;

   function AuswahlNeu (AuswahlOderAnzeige : in Boolean; FrageDatei, FrageZeile, TextDatei, ErsteZeile, LetzteZeile : in Natural) return Integer with
     Pre => ErsteZeile <= LetzteZeile;

private

   Taste : Wide_Wide_Character;

   AktuelleAuswahl : Natural := 1;
   Anfang : Natural;
   Ende : Natural := 1;
   
end Auswahl;

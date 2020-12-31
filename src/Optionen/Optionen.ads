with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with Eingabe, Anzeige, GlobaleVariablen, Steuerung;

package Optionen is

   procedure Optionen;

private

   Taste : Wide_Wide_Character;

   Wert : Integer;

end Optionen;

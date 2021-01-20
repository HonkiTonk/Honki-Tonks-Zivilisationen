with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with GebaeudeDatenbank, GlobaleVariablen, EinheitenDatenbank, Anzeige, GlobaleDatentypen;
use GlobaleDatentypen;

package Bauen is

   procedure Bauen (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);
   procedure BauzeitEinzeln (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);
   procedure BauzeitAlle;

private

   Taste : Wide_Wide_Character;

   WasGebautWerdenSoll : Integer;
   Ende : Integer;
   AktuelleAuswahl : Integer := 1;

   function AuswahlStadt (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) return Integer;

end Bauen;

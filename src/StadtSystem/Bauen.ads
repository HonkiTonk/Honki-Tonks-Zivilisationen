with GlobaleDatentypen;
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

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package Bauen is

   procedure Bauen (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) with
     Pre => StadtNummer in GlobaleVariablen.StadtGebaut'Range (2);

   procedure BauzeitEinzeln (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) with
     Pre => StadtNummer in GlobaleVariablen.StadtGebaut'Range (2);

   procedure BauzeitAlle;

private

   Taste : Wide_Wide_Character;

   WasGebautWerdenSoll : Integer;
   Ende : Integer;
   AktuelleAuswahl : Integer := 1;

   function AuswahlStadt (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) return Integer with
     Pre => StadtNummer in GlobaleVariablen.StadtGebaut'Range (2);

end Bauen;

pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

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

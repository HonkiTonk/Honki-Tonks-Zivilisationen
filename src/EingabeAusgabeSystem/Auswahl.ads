pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen;
use GlobaleDatentypen;

package Auswahl is

   function AuswahlSprache return Unbounded_Wide_Wide_String;

   function Auswahl (FrageDatei, TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; FrageZeile, ErsteZeile, LetzteZeile : in Natural) return Integer with
     Pre => (ErsteZeile <= LetzteZeile and (if FrageDatei = GlobaleDatentypen.Leer then FrageZeile = 0) and (if FrageZeile = 0 then FrageDatei = GlobaleDatentypen.Leer) and TextDatei /= GlobaleDatentypen.Leer);

   function AuswahlJaNein (FrageZeile : in Positive) return Integer with
     Pre => (FrageZeile /= 0);

private

   Taste : Wide_Wide_Character;

   AktuelleAuswahl : Natural := 1;
   Anfang : Natural;
   Ende : Natural := 1;
   
end Auswahl;

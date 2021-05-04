pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen;
use GlobaleDatentypen;

package Auswahl is

   function AuswahlSprache
     return Unbounded_Wide_Wide_String;

   function Auswahl
     (FrageDateiExtern, TextDateiExtern : in GlobaleDatentypen.Welche_Datei_Enum;
      FrageZeileExtern, ErsteZeileExtern, LetzteZeileExtern : in Natural)
      return Integer
     with
       Pre =>
         (ErsteZeileExtern <= LetzteZeileExtern
          and
            (if FrageDateiExtern = GlobaleDatentypen.Leer then FrageZeileExtern = 0)
          and
            (if FrageZeileExtern = 0 then FrageDateiExtern = GlobaleDatentypen.Leer)
          and
            TextDateiExtern /= GlobaleDatentypen.Leer);

   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return Integer;
   
   function AllgemeinAuswahl
     (AktuelleAuswahlExtern, EndeExtern : in Natural)
     return Natural;

private

   Taste : Wide_Wide_Character;

   AktuelleAuswahl : Natural;
   Anfang : Natural;
   Ende : Natural;

   JaNein : Integer;
   
end Auswahl;

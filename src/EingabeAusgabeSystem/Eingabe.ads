pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen;
use GlobaleDatentypen;

package Eingabe is

   function GanzeZahl (Zahlengröße : Positive) return Integer;

   function GanzeZahlNeu (WelcheDatei, WelcherText, ZahlenMinimum, ZahlenMaximum  : Natural) return Integer with
     Pre => ZahlenMaximum <= 999_999_999 and ZahlenMinimum <= ZahlenMaximum;

   function StadtName return Unbounded_Wide_Wide_String;
   function SpielstandName return Unbounded_Wide_Wide_String;

private

   Zahlen : Wide_Wide_Character;

   Test : GlobaleDatentypen.LoopRangeMinusZweiZuZwei;
   IstZahl : GlobaleDatentypen.LoopRangeMinusZweiZuZwei;

   Wert : Integer;
   AktuelleZahlenPosition : Positive;

   ZahlenString : Wide_Wide_String (1 .. 9);

   Name : Unbounded_Wide_Wide_String;
   Zahl : Unbounded_Wide_Wide_String;


   type SchleifenArray is array (1 .. 9) of Boolean;
   Schleifen : SchleifenArray;

   function ZahlPrüfung (Zeichen : in Wide_Wide_Character) return GlobaleDatentypen.LoopRangeMinusZweiZuZwei;
   function ZahlSchleife (ZahlenMinimum, ZahlenMaximum : in Natural; WelcheZahlenposition : in Positive) return GlobaleDatentypen.LoopRangeMinusZweiZuZwei;

end Eingabe;

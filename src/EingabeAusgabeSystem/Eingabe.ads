pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleDatentypen;
use GlobaleDatentypen;

package Eingabe is

   function GanzeZahl (WelcheDatei, WelcherText : in Natural; ZahlenMinimum, ZahlenMaximum : Integer) return Integer with
     Pre => (ZahlenMaximum <= 999_999_999 and ZahlenMinimum < ZahlenMaximum and ZahlenMinimum >= -999_999_999);

   function StadtName return Unbounded_Wide_Wide_String;
   function SpielstandName return Unbounded_Wide_Wide_String;

private

   VorherNurNullstellen : Boolean;
   WelchesVorzeichen : Boolean;

   Zahlen : Wide_Wide_Character;

   Test : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
   IstZahl : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   Wert : Integer;

   ZahlenString : Wide_Wide_String (1 .. 9);

   Name : Unbounded_Wide_Wide_String;

   function GanzeZahlPrüfung (Zeichen : in Wide_Wide_Character) return GlobaleDatentypen.LoopRangeMinusDreiZuDrei with
     Pre => (Zeichen = '0' or Zeichen = '1' or Zeichen = '2' or Zeichen = '3' or Zeichen = '4' or Zeichen = '5' or Zeichen = '6' or Zeichen = '7' or Zeichen = '8' or Zeichen = '9' or Zeichen = '-' or Zeichen = '+'
             or Zeichen = 'q' or Zeichen = DEL or Zeichen = 'e' or Zeichen = 'Q' or Zeichen = 'E');

   function ZahlSchleife (WelcheDatei, WelcherText : in Natural; ZahlenMinimum, ZahlenMaximum : Integer) return GlobaleDatentypen.LoopRangeMinusZweiZuZwei with
     Pre => (ZahlenMaximum <= 999_999_999 and ZahlenMinimum < ZahlenMaximum and ZahlenMinimum >= -999_999_999);

end Eingabe;

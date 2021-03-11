pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen;
use GlobaleDatentypen;

package Eingabe is

   function GanzeZahl (TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; Zeile : in Positive; ZahlenMinimum, ZahlenMaximum : in Integer) return Integer with
     Pre  => (ZahlenMaximum <= 999_999_999 and ZahlenMinimum < ZahlenMaximum and ZahlenMinimum >= -999_999_999),
     Post => (GanzeZahl'Result in -1_000_000_000 .. 999_999_999);

   function StadtName return Unbounded_Wide_Wide_String;
   function SpielstandName return Unbounded_Wide_Wide_String;
   function TastenEingabe return Wide_Wide_Character;

private

   VorherNurNullstellen : Boolean;
   WelchesVorzeichen : Boolean;

   Zahlen : Wide_Wide_Character;

   SchleifeVerlassen : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
   IstZahl : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   Wert : Integer;

   ZahlenString : Wide_Wide_String (1 .. 9);

   Name : Unbounded_Wide_Wide_String;

   function GanzeZahlPrüfung (Zeichen : in Wide_Wide_Character) return GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   function ZahlSchleife (TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; Zeile : in Positive; ZahlenMinimum, ZahlenMaximum : in Integer) return GlobaleDatentypen.LoopRangeMinusZweiZuZwei with
     Pre => (ZahlenMaximum <= 999_999_999 and ZahlenMinimum < ZahlenMaximum and ZahlenMinimum >= -999_999_999);

end Eingabe;

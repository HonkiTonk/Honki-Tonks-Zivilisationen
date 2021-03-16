pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen;
use GlobaleDatentypen;

package Eingabe is

   function GanzeZahl (TextDateiExtern : in GlobaleDatentypen.WelcheDatei_Enum; ZeileExtern : in Positive; ZahlenMinimumExtern, ZahlenMaximumExtern : in Integer) return Integer with
     Pre  => (ZahlenMaximumExtern <= 999_999_999 and ZahlenMinimumExtern < ZahlenMaximumExtern and ZahlenMinimumExtern >= -999_999_999),
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

   function GanzeZahlPrüfung (ZeichenExtern : in Wide_Wide_Character) return GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   function ZahlSchleife (TextDateiExtern : in GlobaleDatentypen.WelcheDatei_Enum; ZeileExtern : in Positive; ZahlenMinimumExtern, ZahlenMaximumExtern : in Integer) return GlobaleDatentypen.LoopRangeMinusZweiZuZwei with
     Pre => (ZahlenMaximumExtern <= 999_999_999 and ZahlenMinimumExtern < ZahlenMaximumExtern and ZahlenMinimumExtern >= -999_999_999);

end Eingabe;

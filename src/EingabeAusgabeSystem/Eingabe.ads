with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleVariablen, Anzeige;

package Eingabe is

   function GanzeZahl (Zahlengröße : Positive) return Integer;

   function GanzeZahlNeu (WelcheDatei, WelcherText, ZahlenMinimum, ZahlenMaximum  : Natural) return Integer with
     Pre => ZahlenMaximum <= 999_999_999 and ZahlenMinimum <= ZahlenMaximum;

   function StadtName return Unbounded_Wide_Wide_String;
   function SpielstandName return Unbounded_Wide_Wide_String;

private

   Wert : Integer;

   Zahlen : Wide_Wide_Character;

   IstZahl : Integer;

   ZahlenString : Wide_Wide_String (1 .. 9);

   Name : Unbounded_Wide_Wide_String;
   Zahl : Unbounded_Wide_Wide_String;


   type SchleifenArray is array (1 .. 9) of Boolean;
   Schleifen : SchleifenArray;

   function ZahlPrüfung (Zeichen : in Wide_Wide_Character) return Integer;

end Eingabe;

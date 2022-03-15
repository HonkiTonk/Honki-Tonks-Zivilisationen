pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package Laden is

   function LadenNeu
     return Boolean;

private

   VersionsnummerPrüfung : Wide_Wide_String (1 .. 9);

   DateiLadenNeu : File_Type;

   procedure SonstigesLaden;
   procedure KarteLaden;
   procedure RassenGrenzenLaden;
   procedure EinheitenLaden;
   procedure StädteLaden;
   procedure WichtigesLaden;
   procedure DiplomatieLaden;
   procedure CursorLaden;

end Laden;

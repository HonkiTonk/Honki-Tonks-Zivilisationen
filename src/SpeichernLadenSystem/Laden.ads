pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded, Ada.Streams.Stream_IO;
use Ada.Strings.Wide_Wide_Unbounded, Ada.Streams.Stream_IO;

package Laden is

   procedure LadenNeu;

private

   Wahl : Integer;

   VersionsnummerPrüfung : Wide_Wide_String (1 .. 9);

   SpielstandName : Unbounded_Wide_Wide_String;

   DateiLadenNeu : File_Type;

end Laden;

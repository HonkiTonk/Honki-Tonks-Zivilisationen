pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded, Ada.Streams.Stream_IO;
use Ada.Strings.Wide_Wide_Unbounded, Ada.Streams.Stream_IO;

package Laden is

   function LadenNeu
     return Boolean;

private

   VersionsnummerPrüfung : Wide_Wide_String (1 .. 9);

   SpielstandName : Unbounded_Wide_Wide_String;

   type SpielständeArray is array (1 .. 10) of Unbounded_Wide_Wide_String;
   VorhandeneSpielstände : SpielständeArray;

   DateiLadenNeu : File_Type;

   procedure LeerwerteSetzen;

end Laden;

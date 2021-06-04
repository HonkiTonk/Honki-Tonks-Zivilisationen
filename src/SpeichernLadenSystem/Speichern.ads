pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded, Ada.Streams.Stream_IO;
use Ada.Strings.Wide_Wide_Unbounded, Ada.Streams.Stream_IO;

with GlobaleDatentypen;
use GlobaleDatentypen;

package Speichern is

   procedure SpeichernNeu
     (AutospeichernExtern : in Boolean);

   procedure AutoSpeichern;

private

   Trennzeichen : constant Wide_Wide_Character := ' ';

   AutospeichernWert : Positive := 1;

   KartenPlusWert : GlobaleDatentypen.Kartenfeld;

   SpielstandName : Unbounded_Wide_Wide_String;

   DateiSpeichernNeu : File_Type;

end Speichern;

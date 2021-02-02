with Ada.Strings.Wide_Wide_Unbounded, Ada.Streams.Stream_IO;
use Ada.Strings.Wide_Wide_Unbounded, Ada.Streams.Stream_IO;

with GlobaleDatentypen;
use GlobaleDatentypen;

package Laden is

   procedure LadenNeu;

private

   KartenPlusWert : GlobaleDatentypen.Kartenfeld;

   SpielstandName : Unbounded_Wide_Wide_String;

   DateiLadenNeu : File_Type;

end Laden;

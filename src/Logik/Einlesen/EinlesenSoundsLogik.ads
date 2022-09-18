pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package EinlesenSoundsLogik is

   procedure EinlesenSounds;

private

   Platzhalter : Boolean := True;

   AktuelleZeile : Positive;

   Sound : Unbounded_Wide_Wide_String;

   DateiSounds : File_Type;

end EinlesenSoundsLogik;

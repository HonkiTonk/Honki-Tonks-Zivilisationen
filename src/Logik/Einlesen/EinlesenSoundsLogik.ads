with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package EinlesenSoundsLogik is
   pragma Elaborate_Body;

   procedure EinlesenSounds;

private

   AktuelleZeile : Positive;

   Sound : Unbounded_Wide_Wide_String;

   DateiSounds : File_Type;

end EinlesenSoundsLogik;

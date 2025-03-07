private with Ada.Wide_Wide_Text_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

package EinlesenSoundsLogik is
   pragma Elaborate_Body;

   procedure EinlesenSounds;

private
   use Ada.Wide_Wide_Text_IO;
   use Ada.Strings.Wide_Wide_Unbounded;

   AktuelleZeile : Positive;

   Soundname : Unbounded_Wide_Wide_String;
   GesamterPfad : Unbounded_Wide_Wide_String;

   DateiSounds : File_Type;

end EinlesenSoundsLogik;

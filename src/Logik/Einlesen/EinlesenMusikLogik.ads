private with Ada.Wide_Wide_Text_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

package EinlesenMusikLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenMusik;
   
private
   use Ada.Wide_Wide_Text_IO;
   use Ada.Strings.Wide_Wide_Unbounded;
         
   AktuelleZeile : Positive;
   
   Lied : Unbounded_Wide_Wide_String;
   
   DateiMusik : File_Type;

end EinlesenMusikLogik;

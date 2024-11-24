private with Ada.Wide_Wide_Text_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

package EinlesenMusikLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenMusik;
   
private
   use Ada.Wide_Wide_Text_IO;
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Intromusik : constant Positive := 1;
   StandardmusikAnfang : constant Positive := Intromusik + 1;
   StandardmusikEnde : constant Positive := Intromusik + 3;
   Forschungserfolg : constant Positive := StandardmusikEnde + 1;
   
   AktuelleZeile : Positive;
   EinzulesendeZeile : Positive;
   
   Dateiname : Unbounded_Wide_Wide_String;
   GesamterPfad : Unbounded_Wide_Wide_String;
   
   DateiMusik : File_Type;
      
end EinlesenMusikLogik;

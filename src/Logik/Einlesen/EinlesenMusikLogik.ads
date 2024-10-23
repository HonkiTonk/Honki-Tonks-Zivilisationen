private with Ada.Wide_Wide_Text_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

private with SpeziesDatentypen;

package EinlesenMusikLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenMusik;
   
private
   use Ada.Wide_Wide_Text_IO;
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Platzhalter : Boolean := True;
      
   AktuelleZeile : Positive;
   
   Lied : Unbounded_Wide_Wide_String;
   
   DateiVerzeichnisse : File_Type;
   DateiMusik : File_Type;
   
   procedure EinlesenLieder
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Enum);

end EinlesenMusikLogik;

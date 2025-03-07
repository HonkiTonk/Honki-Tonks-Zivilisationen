private with Ada.Directories;
private with Ada.Strings.Wide_Wide_Unbounded;

package EinlesenSetsLogik is
   pragma Elaborate_Body;

   function EinlesenSets
     (OrdnerExtern : in String)
      return Boolean
     with
       Pre => (
                 OrdnerExtern'Length > 0
              );
   
private
   use Ada.Directories;
   use Ada.Strings.Wide_Wide_Unbounded;

   SchleifenAbzug : Natural;
   
   Verzeichnisname : Unbounded_Wide_Wide_String;
   Zwischenspeicher : Unbounded_Wide_Wide_String;

   Suche : Search_Type;

   Verzeichnis : Directory_Entry_Type;
   
   procedure SetsSortieren;

end EinlesenSetsLogik;

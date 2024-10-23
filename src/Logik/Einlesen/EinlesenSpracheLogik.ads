private with Ada.Strings.Wide_Wide_Unbounded;
private with Ada.Directories;

package EinlesenSpracheLogik is
   pragma Elaborate_Body;
   
   function EinlesenSprache
     return Boolean;
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   use Ada.Directories;
   
   SchleifenAbzug : Natural;
      
   Zwischenspeicher : Unbounded_Wide_Wide_String;
   Verzeichnisname : Unbounded_Wide_Wide_String;
   
   Suche : Search_Type;
   
   Verzeichnis : Directory_Entry_Type;
   
   procedure SprachenSortieren;

end EinlesenSpracheLogik;

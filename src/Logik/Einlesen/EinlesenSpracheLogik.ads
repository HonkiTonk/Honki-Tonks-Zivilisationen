with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Directories; use Ada.Directories;

package EinlesenSpracheLogik is
   pragma Elaborate_Body;
   
   function EinlesenSprache
     return Boolean;
   
private
      
   SchleifenAbzug : Natural;
      
   ZwischenSpeicher : Unbounded_Wide_Wide_String;
   Test : Unbounded_Wide_Wide_String;
   
   Suche : Search_Type;
   
   Verzeichnis : Directory_Entry_Type;
   
   procedure SprachenSortieren;
   
   
   
   function Ordnernamen
     (NameExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 NameExtern'Length > 0
              );

end EinlesenSpracheLogik;

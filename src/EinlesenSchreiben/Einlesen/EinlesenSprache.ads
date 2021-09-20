pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded, Ada.Directories;
use Ada.Strings.Wide_Wide_Unbounded, Ada.Directories;


package EinlesenSprache is
   
   function EinlesenSprache
     return Boolean;
   
private
   
   SchleifenAbzug : Natural;
   
   ZwischenSpeicher : Unbounded_Wide_Wide_String;
   
   Suche : Search_Type;
   
   Verzeichnis : Directory_Entry_Type;
   
   procedure SprachenSortieren;

end EinlesenSprache;

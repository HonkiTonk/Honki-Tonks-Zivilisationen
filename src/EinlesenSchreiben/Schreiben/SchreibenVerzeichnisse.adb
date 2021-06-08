pragma SPARK_Mode (On);

with Ada.Directories;
use Ada.Directories;

package body SchreibenVerzeichnisse is

   procedure SchreibenVerzeichnisse
   is begin

      case
        Exists (Name => "Sprachen")
      is
         when True =>
            null;
            
         when False =>
            Create_Directory (New_Directory => "Sprachen");
      end case;
      
      case
        Exists (Name => "Spielstand")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Spielstand");
      end case;
      
      case
        Exists (Name => "Einstellungen")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Einstellungen");
      end case;
      
      case
        Exists (Name => "Daten")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Daten");
      end case;
      
   end SchreibenVerzeichnisse;

end SchreibenVerzeichnisse;

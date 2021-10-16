pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;

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
        Exists (Name => "Datenbanken")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Datenbanken");
      end case;
      
      -- Erstellung eines Grafik- oder Soundordners ist sinnfrei, da das Programm ja keine Grafiken/Sounds generieren kann;
      
      case
        Exists (Name => "Grafik")
      is
         when True =>
            null;

         when False =>
            -- Hier später einen raise Programm_Error einbauen.
            null;
      end case;
      
      case
        Exists (Name => "Sound")
      is
         when True =>
            null;

         when False =>
            -- Hier später einen raise Programm_Error einbauen.
            null;
      end case;
      
   end SchreibenVerzeichnisse;

end SchreibenVerzeichnisse;

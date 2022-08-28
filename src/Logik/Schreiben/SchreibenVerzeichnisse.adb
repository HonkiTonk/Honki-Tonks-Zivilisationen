pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with TextKonstanten;

package body SchreibenVerzeichnisse is

   procedure SchreibenVerzeichnisse
   is begin
      
      SchreibeSonstigeVerzeichnisse;
      
   end SchreibenVerzeichnisse;
   
   
   
   procedure SchreibeSonstigeVerzeichnisse
   is begin
                  
      case
        Exists (Name => TextKonstanten.Spielstand)
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => TextKonstanten.Spielstand);
      end case;
      
      case
        Exists (Name => TextKonstanten.Datenbanken)
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => TextKonstanten.Datenbanken);
      end case;
      
   end SchreibeSonstigeVerzeichnisse;

end SchreibenVerzeichnisse;

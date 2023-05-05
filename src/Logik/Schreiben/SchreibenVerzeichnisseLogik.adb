with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;

package body SchreibenVerzeichnisseLogik is

   procedure SchreibenVerzeichnisse
   is begin
      
      SchreibeSonstigeVerzeichnisse;
      
   end SchreibenVerzeichnisse;
   
   
   
   procedure SchreibeSonstigeVerzeichnisse
   is begin
                  
      case
        Exists (Name => VerzeichnisKonstanten.Spielstand)
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => VerzeichnisKonstanten.Spielstand);
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.Datenbanken)
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => VerzeichnisKonstanten.Datenbanken);
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.Einstellungen)
      is
         when True =>
            null;
            
         when False =>
            Create_Directory (New_Directory => VerzeichnisKonstanten.Einstellungen);
      end case;
      
   end SchreibeSonstigeVerzeichnisse;

end SchreibenVerzeichnisseLogik;

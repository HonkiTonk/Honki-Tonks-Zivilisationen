with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;

with Fehlermeldungssystem;

package body SchreibenVerzeichnisseLogik is

   procedure SchreibenVerzeichnisse
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
      
   exception
      when Status_Error | Name_Error | Use_Error | Device_Error =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenVerzeichnisseLogik.SchreibenVerzeichnisse - Konnte nicht geschrieben werden");
      
   end SchreibenVerzeichnisse;

end SchreibenVerzeichnisseLogik;

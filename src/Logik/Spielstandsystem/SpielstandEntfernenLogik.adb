with Ada.Directories; use Ada.Directories;

with TextnummernKonstanten;

with JaNeinLogik;
with UmwandlungenVerzeichnisse;

package body SpielstandEntfernenLogik is

   procedure SpielstandEntfernen
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String;
      ManuellAutoExtern : in SystemDatentypen.Spielstand_Enum)
   is begin
      
      case
        JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageSpielstandLöschen)
      is
         when True =>
            Delete_File (Name => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => ManuellAutoExtern,
                                                                           SpielstandnameExtern => SpielstandnameExtern));
            
         when False =>
            null;
      end case;
      
   end SpielstandEntfernen;

end SpielstandEntfernenLogik;

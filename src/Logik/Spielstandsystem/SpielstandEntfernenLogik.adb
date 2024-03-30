with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

-- with VerzeichnisKonstanten;
with TextnummernKonstanten;

with JaNeinLogik;
with SpielstandKonstanten;

package body SpielstandEntfernenLogik is

   procedure SpielstandEntfernen
     (SpielstandnameExtern : in Wide_Wide_String;
      ManuellAutoExtern : in SpielstandDatentypen.Spielstand_Enum)
   is begin
      
      if
        SpielstandnameExtern'Length = 0
      then
         null;
          
      elsif
        JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageSpielstandLöschen) = False
      then
         null;
         
      else
         Delete_File (Name => Encode (Item => To_Wide_Wide_String (Source => SpielstandKonstanten.Verzeichnisse (ManuellAutoExtern))) & Encode (Item => SpielstandnameExtern));
        -- case
        --   ManuellAutoExtern
        -- is
        --    when SpielstandDatentypen.Manueller_Spielstand_Enum =>
          --     Delete_File (Name => (VerzeichnisKonstanten.SpielstandStrich & Encode (Item => VerzeichnisKonstanten.SpielstandSpielerStrich) & Encode (Item => SpielstandnameExtern)));
               
          --  when SpielstandDatentypen.Automatischer_Spielstand_Enum =>
          --     Delete_File (Name => (VerzeichnisKonstanten.SpielstandStrich & Encode (Item => VerzeichnisKonstanten.SpielstandAutoStrich) & Encode (Item => SpielstandnameExtern)));
        -- end case;
      end if;
      
   end SpielstandEntfernen;

end SpielstandEntfernenLogik;

with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
with TextnummernKonstanten;

with JaNeinLogik;

package body SpielstandEntfernenLogik is

   procedure SpielstandEntfernen
     (SpielstandnameExtern : in Wide_Wide_String)
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
         Delete_File (Name => (VerzeichnisKonstanten.SpielstandStrich & Encode (Item => SpielstandnameExtern)));
      end if;
      
   end SpielstandEntfernen;

end SpielstandEntfernenLogik;

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;

package EinlesenAllgemeinesLogik is
   pragma Elaborate_Body;

   function VorzeitigesZeilenende
     (AktuelleDateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive)
      return Boolean;

   function LeeresVerzeichnis
     (VerzeichnisExtern : in String)
      return Boolean
     with
       Pre => (
                 VerzeichnisExtern'Length > VerzeichnisKonstanten.Sprachenordner'Length
              );

private

   Prüfungssuche : Search_Type;

   Verzeichnisprüfung : Directory_Entry_Type;

   KleinsteOrdnergröße : constant File_Size := 0;

end EinlesenAllgemeinesLogik;

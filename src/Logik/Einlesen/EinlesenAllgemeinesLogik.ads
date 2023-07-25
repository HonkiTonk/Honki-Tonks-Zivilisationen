with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Directories; use Ada.Directories;

with Sf.Graphics;

private with Sf;
private with Sf.Graphics.Texture;
private with Sf.System.Vector2;

with VerzeichnisKonstanten;

package EinlesenAllgemeinesLogik is
   pragma Elaborate_Body;

   function VorzeitigesZeilenende
     (AktuelleDateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive;
      DateiExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 DateiExtern'Length > 0
              );

   function NamensprüfungWindows
     (NameExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 NameExtern'Length > 0
              );

   function LeeresVerzeichnis
     (VerzeichnisExtern : in String)
      return Boolean
     with
       Pre => (
                 VerzeichnisExtern'Length > VerzeichnisKonstanten.Sprachenordner'Length
              );

   function Texturenlimit
     (TexturenpfadExtern : in String)
      return Sf.Graphics.sfTexture_Ptr
     with
       Pre => (
                 TexturenpfadExtern'Length > 0
              );

private

   Prüfungssuche : Search_Type;

   Verzeichnisprüfung : Directory_Entry_Type;

   KleinsteOrdnergröße : constant File_Size := 0;

   MaximaleTexturengröße : constant Sf.sfUint32 := Sf.Graphics.Texture.getMaximumSize;

   Texturengröße : Sf.System.Vector2.sfVector2u;

end EinlesenAllgemeinesLogik;

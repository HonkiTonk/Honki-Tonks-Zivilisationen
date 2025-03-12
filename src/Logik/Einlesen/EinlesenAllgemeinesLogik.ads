with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Ada.Directories;

with Sf.Graphics;

private with Sf;
private with Sf.Graphics.Texture;

package EinlesenAllgemeinesLogik is
   pragma Elaborate_Body;

   function VorzeitigesDateienende
     (AktuelleDateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive;
      DateinameExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 DateinameExtern'Length > 0
              );

   function TextEinlesen
     (DateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive;
      DateinameExtern : in Wide_Wide_String)
      return Wide_Wide_String
     with
       Pre => (
                 DateinameExtern'Length > 0
              );

   function TextEinlesenUngebunden
     (DateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive;
      DateinameExtern : in Wide_Wide_String)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 DateinameExtern'Length > 0
              );

   function TexturFestlegen
     (TexturenAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturenpfadExtern : in String)
      return Sf.Graphics.sfTexture_Ptr
     with
       Pre => (
                 TexturenpfadExtern'Length > 0
              );

private
   use Ada.Directories;

   Prüfungssuche : Search_Type;

   Verzeichnisprüfung : Directory_Entry_Type;

   MaximaleTexturengröße : constant Sf.sfUint32 := Sf.Graphics.Texture.getMaximumSize;

end EinlesenAllgemeinesLogik;

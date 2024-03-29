with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;

private with Sf;
private with Sf.Graphics.Texture;
private with Sf.System.Vector2;

with VerzeichnisKonstanten;

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

   function VerboteneVerzeichnissnamen
     (NameExtern : in String)
      return Boolean
     with
       Pre => (
                 NameExtern'Length > 0
              );

private

   Prüfungssuche : Search_Type;

   Verzeichnisprüfung : Directory_Entry_Type;

   KleinsteOrdnergröße : constant File_Size := 0;

   MaximaleTexturengröße : constant Sf.sfUint32 := Sf.Graphics.Texture.getMaximumSize;

   Texturengröße : Sf.System.Vector2.sfVector2u;

end EinlesenAllgemeinesLogik;

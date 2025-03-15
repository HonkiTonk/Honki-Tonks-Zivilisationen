with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package EinlesenAllgemeinesHTSEB is
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

   function DateinamenEinlesenUngebunden
     (DateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive;
      DateinameExtern : in Wide_Wide_String)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 DateinameExtern'Length > 0
              );

end EinlesenAllgemeinesHTSEB;

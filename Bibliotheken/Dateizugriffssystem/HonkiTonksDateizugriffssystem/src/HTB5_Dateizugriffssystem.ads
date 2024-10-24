with Ada.Streams.Stream_IO;
with Ada.Wide_Wide_Text_IO;

package HTB5_Dateizugriffssystem is
   pragma Elaborate_Body;

   procedure ErstellenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in String)
     with
       Pre => (
                 NameExtern'Length > 0
              );

   procedure ÖffnenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in String)
     with
       Pre => (
                 NameExtern'Length > 0
              );
   
   procedure ErstellenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
     with
       Pre => (
                 NameExtern'Length > 0
              );
   
   procedure ÖffnenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
     with
       Pre => (
                 NameExtern'Length > 0
              );
   
   procedure ErweiternText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
     with
       Pre => (
                 NameExtern'Length > 0
              );

end HTB5_Dateizugriffssystem;

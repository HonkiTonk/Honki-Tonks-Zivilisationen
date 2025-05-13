with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Wide_Wide_Text_IO;
with Ada.Streams.Stream_IO;

package DateizugriffssystemHTSEB is
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
   
   procedure SchließenStream
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
   
   procedure SchließenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
     with
       Pre => (
                 NameExtern'Length > 0
              );
   
   procedure ErstellenStreamWideWide
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Wide_Wide_String)
     with
       Pre => (
                 NameExtern'Length > 0
              );

   procedure ÖffnenStreamWideWide
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Wide_Wide_String)
     with
       Pre => (
                 NameExtern'Length > 0
              );
   
   procedure SchließenStreamWideWide
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Wide_Wide_String)
     with
       Pre => (
                 NameExtern'Length > 0
              );
   
   procedure ErstellenTextWideWide
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Wide_Wide_String)
     with
       Pre => (
                 NameExtern'Length > 0
              );
   
   procedure ÖffnenTextWideWide
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Wide_Wide_String)
     with
       Pre => (
                 NameExtern'Length > 0
              );
   
   procedure ErweiternTextWideWide
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Wide_Wide_String)
     with
       Pre => (
                 NameExtern'Length > 0
              );
   
   procedure SchließenTextWideWide
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Wide_Wide_String)
     with
       Pre => (
                 NameExtern'Length > 0
              );

   procedure ErstellenStreamUnbounded
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => NameExtern)'Length > 0
              );

   procedure ÖffnenStreamUnbounded
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => NameExtern)'Length > 0
              );
   
   procedure SchließenStreamUnbounded
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => NameExtern)'Length > 0
              );
   
   procedure ErstellenTextUnbounded
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => NameExtern)'Length > 0
              );
   
   procedure ÖffnenTextUnbounded
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => NameExtern)'Length > 0
              );
   
   procedure ErweiternTextUnbounded
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => NameExtern)'Length > 0
              );
   
   procedure SchließenTextUnbounded
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => NameExtern)'Length > 0
              );
   
   procedure Löschen
     (NameExtern : in String)
     with
       Pre => (
                 NameExtern'Length > 0
              );
   
   procedure LöschenWideWide
     (NameExtern : in Wide_Wide_String)
     with
       Pre => (
                 NameExtern'Length > 0
              );
   
   procedure LöschenUnbounded
     (NameExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => NameExtern)'Length > 0
              );

end DateizugriffssystemHTSEB;

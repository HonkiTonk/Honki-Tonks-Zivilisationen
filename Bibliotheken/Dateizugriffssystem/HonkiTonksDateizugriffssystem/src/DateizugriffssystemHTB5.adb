-- Eine Prozedur für das Schließen einzubauen ist sinnfrei.
-- Es gibt keine verschiedenen Varianten des Schließens und den Paketzugriff bekomme ich auch nicht raus, da ich ja immer noch das File_Type aus dem Standardpaket brauche.

with DateizugriffsvariablenHTB5;

package body DateizugriffssystemHTB5 is

   procedure ErstellenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Streams.Stream_IO;
   begin
      
      Create (File => DateiartExtern,
              Mode => Out_File,
              Name => NameExtern,
              Form => DateizugriffsvariablenHTB5.DateiformAbfragen);
      
   end ErstellenStream;
   
   

   procedure ÖffnenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Streams.Stream_IO;
   begin
      
      Open (File => DateiartExtern,
            Mode => In_File,
            Name => NameExtern,
            Form => DateizugriffsvariablenHTB5.DateiformAbfragen);
      
   end ÖffnenStream;
   
   
   
   procedure ErstellenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Wide_Wide_Text_IO;
   begin
      
      Create (File => DateiartExtern,
              Mode => Out_File,
              Name => NameExtern,
              Form => DateizugriffsvariablenHTB5.DateiformAbfragen);
      
   end ErstellenText;
   
   

   procedure ÖffnenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Wide_Wide_Text_IO;
   begin
      
      Open (File => DateiartExtern,
            Mode => In_File,
            Name => NameExtern,
            Form => DateizugriffsvariablenHTB5.DateiformAbfragen);
      
   end ÖffnenText;
   
   
   
   procedure ErweiternText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Wide_Wide_Text_IO;
   begin
      
      Open (File => DateiartExtern,
            Mode => Append_File,
            Name => NameExtern,
            Form => DateizugriffsvariablenHTB5.DateiformAbfragen);
      
   end ErweiternText;

end DateizugriffssystemHTB5;

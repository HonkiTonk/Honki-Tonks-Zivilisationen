package body DateiLogik is
   
   procedure ErstellenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in String)
   is begin
      
      Ada.Streams.Stream_IO.Create (File => DateiartExtern,
                                    Mode => Ada.Streams.Stream_IO.Out_File,
                                    Name => NameExtern,
                                    Form => "WCEM=8");
      
   end ErstellenStream;
   
   

   procedure ÖffnenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in String)
   is begin
      
      Ada.Streams.Stream_IO.Open (File => DateiartExtern,
                                  Mode => Ada.Streams.Stream_IO.In_File,
                                  Name => NameExtern,
                                  Form => "WCEM=8");
      
   end ÖffnenStream;
   
   
   
   procedure SchließenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type)
   is begin
      
      Ada.Streams.Stream_IO.Close (File => DateiartExtern);
      
   end SchließenStream;
   
   
   
   procedure ErstellenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is begin
      
      Ada.Wide_Wide_Text_IO.Create (File => DateiartExtern,
                                    Mode => Ada.Wide_Wide_Text_IO.Out_File,
                                    Name => NameExtern,
                                    Form => "WCEM=8");
      
   end ErstellenText;
   
   

   procedure ÖffnenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is begin
      
      Ada.Wide_Wide_Text_IO.Open (File => DateiartExtern,
                                  Mode => Ada.Wide_Wide_Text_IO.In_File,
                                  Name => NameExtern,
                                  Form => "WCEM=8");
      
   end ÖffnenText;
   
   
   
   procedure ErweiternText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is begin
      
      Ada.Wide_Wide_Text_IO.Open (File => DateiartExtern,
                                  Mode => Ada.Wide_Wide_Text_IO.Append_File,
                                  Name => NameExtern,
                                  Form => "WCEM=8");
      
   end ErweiternText;
   
   
   
   procedure SchließenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type)
   is begin
      
      Ada.Wide_Wide_Text_IO.Close (File => DateiartExtern);
      
   end SchließenText;
   
end DateiLogik;

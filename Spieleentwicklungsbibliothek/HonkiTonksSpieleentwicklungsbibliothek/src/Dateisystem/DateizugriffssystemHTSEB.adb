with Ada.Exceptions;
with Ada.Directories;

with DateisystemvariablenHTSEB;
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

package body DateizugriffssystemHTSEB is

   procedure ErstellenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Streams.Stream_IO;
      use Ada.Exceptions;
   begin
      
      Create (File => DateiartExtern,
              Mode => Out_File,
              Name => NameExtern,
              Form => DateisystemvariablenHTSEB.DateiformAbfragen);
   
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "DateizugriffssystemHTSEB.ErstellenStream: Stream nicht erstellbar: " & UmwandlungssystemHTSEB.Decode (TextExtern => NameExtern) & "/"
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
   end ErstellenStream;
   
   

   procedure ÖffnenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Streams.Stream_IO;
      use Ada.Exceptions;
   begin
      
      Open (File => DateiartExtern,
            Mode => In_File,
            Name => NameExtern,
            Form => DateisystemvariablenHTSEB.DateiformAbfragen);
   
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "DateizugriffssystemHTSEB.ÖffnenStream: Stream nicht öf­fen­bar: " & UmwandlungssystemHTSEB.Decode (TextExtern => NameExtern) & "/"
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
   end ÖffnenStream;
   
   
   
   procedure SchließenStream
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Streams.Stream_IO;
   begin
      
      case
        Is_Open (File => DateiartExtern)
      is
         when True =>
            Close (File => DateiartExtern);
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "DateizugriffssystemHTSEB.SchließenStream: Ungeöffneter Stream soll geschlossen werden: " & UmwandlungssystemHTSEB.Decode (TextExtern => NameExtern));
      end case;
      
   end SchließenStream;
   
   
   
   
   procedure ErstellenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Wide_Wide_Text_IO;
      use Ada.Exceptions;
   begin
      
      Create (File => DateiartExtern,
              Mode => Out_File,
              Name => NameExtern,
              Form => DateisystemvariablenHTSEB.DateiformAbfragen);
   
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "DateizugriffssystemHTSEB.ErstellenText: Text nicht erstellbar: " & UmwandlungssystemHTSEB.Decode (TextExtern => NameExtern) & "/"
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
   end ErstellenText;
   
   

   procedure ÖffnenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Wide_Wide_Text_IO;
      use Ada.Exceptions;
   begin
      
      Open (File => DateiartExtern,
            Mode => In_File,
            Name => NameExtern,
            Form => DateisystemvariablenHTSEB.DateiformAbfragen);
   
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "DateizugriffssystemHTSEB.ÖffnenText: Text nicht öf­fen­bar: " & UmwandlungssystemHTSEB.Decode (TextExtern => NameExtern) & "/"
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
   end ÖffnenText;
   
   
   
   procedure ErweiternText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Wide_Wide_Text_IO;
      use Ada.Exceptions;
   begin
      
      Open (File => DateiartExtern,
            Mode => Append_File,
            Name => NameExtern,
            Form => DateisystemvariablenHTSEB.DateiformAbfragen);
   
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "DateizugriffssystemHTSEB.ErweiternText: Text nicht öf­fen­bar: " & UmwandlungssystemHTSEB.Decode (TextExtern => NameExtern) & "/"
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
   end ErweiternText;
   
   
   
   procedure SchließenText
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in String)
   is
      use Ada.Wide_Wide_Text_IO;
   begin
      
      case
        Is_Open (File => DateiartExtern)
      is
         when True =>
            Close (File => DateiartExtern);
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "DateizugriffssystemHTSEB.SchließenStream: Ungeöffneter Stream soll geschlossen werden: " & UmwandlungssystemHTSEB.Decode (TextExtern => NameExtern));
      end case;
      
   end SchließenText;
   
   
   
   procedure ErstellenStreamWideWide
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Wide_Wide_String)
   is begin
      
      ErstellenStream (DateiartExtern => DateiartExtern,
                       NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => NameExtern));
      
   end ErstellenStreamWideWide;
   
   

   procedure ÖffnenStreamWideWide
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Wide_Wide_String)
   is begin
      
      ÖffnenStream (DateiartExtern => DateiartExtern,
                     NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => NameExtern));
      
   end ÖffnenStreamWideWide;
   
   
   
   procedure SchließenStreamWideWide
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Wide_Wide_String)
   is begin
      
      SchließenStream (DateiartExtern => DateiartExtern,
                        NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => NameExtern));
      
   end SchließenStreamWideWide;
   
   
   
   procedure ErstellenTextWideWide
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Wide_Wide_String)
   is begin
      
      ErstellenText (DateiartExtern => DateiartExtern,
                     NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => NameExtern));
      
   end ErstellenTextWideWide;
   
   
   
   procedure ÖffnenTextWideWide
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Wide_Wide_String)
   is begin
      
      ÖffnenText (DateiartExtern => DateiartExtern,
                   NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => NameExtern));
      
   end ÖffnenTextWideWide;
   
   
   
   procedure ErweiternTextWideWide
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Wide_Wide_String)
   is begin
      
      ErweiternText (DateiartExtern => DateiartExtern,
                     NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => NameExtern));
      
   end ErweiternTextWideWide;
   
   
   
   procedure SchließenTextWideWide
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Wide_Wide_String)
   is begin
      
      SchließenText (DateiartExtern => DateiartExtern,
                      NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => NameExtern));
      
   end SchließenTextWideWide;
   
   
   
   procedure ErstellenStreamUnbounded
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      ErstellenStream (DateiartExtern => DateiartExtern,
                       NameExtern     => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => NameExtern));
         
   end ErstellenStreamUnbounded;
   
   

   procedure ÖffnenStreamUnbounded
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      ÖffnenStream (DateiartExtern => DateiartExtern,
                     NameExtern     => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => NameExtern));
      
   end ÖffnenStreamUnbounded;
   
   
   
   procedure SchließenStreamUnbounded
     (DateiartExtern : in out Ada.Streams.Stream_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      SchließenStream (DateiartExtern => DateiartExtern,
                        NameExtern     => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => NameExtern));
      
   end SchließenStreamUnbounded;
   
   
   
   procedure ErstellenTextUnbounded
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      ErstellenText (DateiartExtern => DateiartExtern,
                     NameExtern     => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => NameExtern));
      
   end ErstellenTextUnbounded;
   
   
   
   procedure ÖffnenTextUnbounded
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      ÖffnenText (DateiartExtern => DateiartExtern,
                   NameExtern     => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => NameExtern));
      
   end ÖffnenTextUnbounded;
   
   
   
   procedure ErweiternTextUnbounded
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      ErweiternText (DateiartExtern => DateiartExtern,
                     NameExtern     => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => NameExtern));
      
   end ErweiternTextUnbounded;
   
   
   
   procedure SchließenTextUnbounded
     (DateiartExtern : in out Ada.Wide_Wide_Text_IO.File_Type;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      SchließenText (DateiartExtern => DateiartExtern,
                      NameExtern     => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => NameExtern));
      
   end SchließenTextUnbounded;
   
   
   
   procedure Löschen
     (NameExtern : in String)
   is
      use Ada.Directories;
   begin
      
      case
        Exists (Name => NameExtern)
      is
         when True =>
            Delete_File (Name => NameExtern);
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "DateizugriffssystemHTSEB.Löschen: Nicht vorhandene Datei soll gelöscht werden: " & UmwandlungssystemHTSEB.Decode (TextExtern => NameExtern));
      end case;
      
   end Löschen;
   
   
   
   procedure LöschenWideWide
     (NameExtern : in Wide_Wide_String)
   is begin
      
      Löschen (NameExtern => UmwandlungssystemHTSEB.Encode (TextExtern => NameExtern));
      
   end LöschenWideWide;
   
   
   
   procedure LöschenUnbounded
     (NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
       Löschen (NameExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => NameExtern));
      
   end LöschenUnbounded;

end DateizugriffssystemHTSEB;

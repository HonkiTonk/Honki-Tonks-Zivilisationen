-- Eine Prozedur für das Schließen einzubauen ist sinnfrei.
-- Es gibt keine verschiedenen Varianten des Schließens und den Paketzugriff bekomme ich auch nicht raus, da ich ja immer noch das File_Type aus dem Standardpaket brauche.
-- Aber enventuell sinnvoll für die WideWide und Unbounded Versionen?
-- Mal drüber nachdenken. äöü
-- Löschen eventuell auch? äöü
with Ada.Exceptions;

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

end DateizugriffssystemHTSEB;

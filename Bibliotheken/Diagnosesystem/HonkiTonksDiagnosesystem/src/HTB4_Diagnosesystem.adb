with Ada.Wide_Wide_Text_IO;
with Ada.Directories;
with Ada.Float_Text_IO;
with Ada.Text_IO;

package body HTB4_Diagnosesystem is
   
   procedure Größenprüfung
     (DatentypgrößeExtern : in Positive)
   is
      use Ada.Wide_Wide_Text_IO;
   begin
      
      Put_Line (Item => "Bits:" & DatentypgrößeExtern'Wide_Wide_Image);
      Put_Line (Item => "Bytes:" & Integer (DatentypgrößeExtern / ByteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Kilobytes:" & Integer (DatentypgrößeExtern / KilobyteTeiler)'Wide_Wide_Image);
      Put_Line (Item => "Megabytes:" & Integer (DatentypgrößeExtern / MegabyteTeiler)'Wide_Wide_Image);
      
   end Größenprüfung;
   
   
   
   procedure Zeilenabstand
   is
      use Ada.Wide_Wide_Text_IO;
   begin
      
      New_Line;
      
   end Zeilenabstand;
   
   
   
   procedure Zahl
     (ZahlExtern : in Integer)
   is
      use Ada.Wide_Wide_Text_IO;
   begin
      
      Put_Line (ZahlExtern'Wide_Wide_Image);
      
   end Zahl;
   
   
   procedure Kommazahl
     (ZahlExtern : in Float)
   is
      use Ada.Wide_Wide_Text_IO;
      use Ada.Float_Text_IO;
   begin
      
      Put (Item => ZahlExtern,
           Exp  => 0);
      
      New_Line;
      
   end Kommazahl;
   
   
   
   procedure Zeichen
     (ZeichenExtern : in Wide_Wide_Character)
   is
      use Ada.Wide_Wide_Text_IO;
   begin
      
      Put_Line (Item => ZeichenExtern'Wide_Wide_Image);
      
   end Zeichen;
   
   
   
   procedure KurzesZeichen
     (ZeichenExtern : in Character)
   is
      use Ada.Text_IO;
   begin
      
      Put_Line (Item => ZeichenExtern'Image);
      
   end KurzesZeichen;
   
   
   
   procedure Text
     (TextExtern : in Wide_Wide_String)
   is
      use Ada.Wide_Wide_Text_IO;
   begin
      
      Put_Line (Item => TextExtern);
      
   end Text;
   
   
   
   procedure UngebundenerText
     (TextExtern : in Unbounded_Wide_Wide_String)
   is
      use Ada.Wide_Wide_Text_IO;
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => TextExtern));
      
   end UngebundenerText;
   
   
   
   procedure KurzerText
     (TextExtern : in String)
   is
      use Ada.Text_IO;
   begin
      
      Put_Line (Item => TextExtern);
      
   end KurzerText;
   
   
   
   procedure Verzeichnisnamen
   is
      use Ada.Text_IO;
      use Ada.Directories;
   begin
      
      Put_Line (Item => Current_Directory);
      
   end Verzeichnisnamen;
   
   
   
   procedure MaximaleDateinamenlänge
   is
      use Ada.Wide_Wide_Text_IO;
      use Ada.Directories;
   begin
      
      Zwischenspeicher := To_Unbounded_String (Source => "");
      
      DateilängeSchleife:
      for DateilängeSchleifenwert in 1 .. MaximaleNamenlänge loop
         
         Put_Line (Item => DateilängeSchleifenwert'Wide_Wide_Image);
         
         Zwischenspeicher := Zwischenspeicher & "a";
      
         Ada.Streams.Stream_IO.Create (File => DateiSpeichern,
                                       Mode => Ada.Streams.Stream_IO.Out_File,
                                       Name => To_String (Source => Zwischenspeicher),
                                       Form => "WCEM=8");
            
         Close (File => DateiSpeichern);
         
         Delete_File (Name => To_String (Source => Zwischenspeicher));
         
      end loop DateilängeSchleife;
      
   end MaximaleDateinamenlänge;

end HTB4_Diagnosesystem;

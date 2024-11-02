with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Ada.Streams.Stream_IO;
private with Ada.Strings.Unbounded;
private with System;

package DiagnosesystemHTB4 is
   pragma Elaborate_Body;

   procedure Größenprüfung
     (DatentypgrößeExtern : in Positive);
   
   procedure Zeilenabstand;
   
   procedure Zahl
     (ZahlExtern : in Integer);
   
   procedure Kommazahl
     (ZahlExtern : in Float);
   
   procedure Zeichen
     (ZeichenExtern : in Wide_Wide_Character);
   
   procedure KurzesZeichen
     (ZeichenExtern : in Character);
   
   procedure Text
     (TextExtern : in Wide_Wide_String)
     with
       Pre => (
                 TextExtern'Length > 0
              );
   
   procedure UngebundenerText
     (TextExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 To_Wide_Wide_String (Source => TextExtern)'Length > 0
              );
   
   procedure KurzerText
     (TextExtern : in String)
     with
       Pre => (
                 TextExtern'Length > 0
              );
   
   procedure Verzeichnisnamen;
      
   procedure MaximaleDateinamenlänge;
   
private
   use System;
   use Ada.Strings.Unbounded;
   use Ada.Streams.Stream_IO;
   
   ByteTeiler : constant Positive := Storage_Unit;
   KilobyteTeiler : constant Positive := ByteTeiler * 1_024;
   MegabyteTeiler : constant Positive := KilobyteTeiler * 1_024;
   MaximaleNamenlänge : constant Positive := 255;
   
   ZuSpeichern : Natural;
         
   DateiSpeichern : File_Type;
   
   Zwischenspeicher : Unbounded_String;

end DiagnosesystemHTB4;

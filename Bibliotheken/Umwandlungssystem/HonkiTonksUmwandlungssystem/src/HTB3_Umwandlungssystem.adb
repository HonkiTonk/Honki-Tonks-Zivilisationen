with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Wide_Wide_Fixed; use Ada.Strings.Wide_Wide_Fixed;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with HTB3_Umwandlungsvariablen;

package body HTB3_Umwandlungssystem is
   
   function Zahlenstring
     (ZahlExtern : in GanzeZahl)
      return Wide_Wide_String
   is begin
      
      if
        ZahlExtern >= 0
      then
         return Trim (Source => ZahlExtern'Wide_Wide_Image,
                      Side   => Ada.Strings.Left);
         
      else
         return ZahlExtern'Wide_Wide_Image;
      end if;
      
   end Zahlenstring;
   
   
   
   -- Aufgrund der Stringlänge geht das nur für die Werte -9_999_999_999,99 .. 9_999_999_999,99.
   function Kommazahlenstring
     (KommazahlExtern : in Kommazahl)
      return Wide_Wide_String
   is begin
      
      Put (To   => ZwischenspeicherKommazahlenstring,
           Item => Float (KommazahlExtern),
           Aft  => 2,
           Exp  => 0);
      
      -- Ist Trim hier überhaupt notwendig? äöü
      return Trim (Source => Dezimaltrennzeichen (ZahlenstringExtern => Decode (TextExtern => ZwischenspeicherKommazahlenstring)),
                   Side   => Ada.Strings.Left);
      
   end Kommazahlenstring;
   
   
   
   function Dezimaltrennzeichen
     (ZahlenstringExtern : in Wide_Wide_String)
      return Wide_Wide_String
   is begin
      
      case
        HTB3_Umwandlungsvariablen.TrennzeichenAbfragen
      is
         when Standardtrennzeichen =>
            return ZahlenstringExtern;
            
         when others =>
            Zwischenspeicher := ZahlenstringExtern;
      end case;
      
      ZahlenSchleife:
      for ZahlenSchleifenwert in Zwischenspeicher'Range loop
         
         case
           Zwischenspeicher (ZahlenSchleifenwert)
         is
            when Standardtrennzeichen =>
               Zwischenspeicher (ZahlenSchleifenwert) := HTB3_Umwandlungsvariablen.TrennzeichenAbfragen;
               exit ZahlenSchleife;
               
            when others =>
               null;
         end case;
         
      end loop ZahlenSchleife;
      
      return Zwischenspeicher;
      
   end Dezimaltrennzeichen;
   
   
   
   function Decode
     (TextExtern : in String)
      return Wide_Wide_String
   is begin
      
      case
        HTB3_Umwandlungsvariablen.KodierungAbfragen
      is
         when Ada.Strings.UTF_Encoding.UTF_8 =>
            return Decode (Item         => TextExtern,
                           Input_Scheme => Ada.Strings.UTF_Encoding.UTF_8);
            
         when Ada.Strings.UTF_Encoding.UTF_16BE =>
            return Decode (Item         => TextExtern,
                           Input_Scheme => Ada.Strings.UTF_Encoding.UTF_16BE);
            
            
         when Ada.Strings.UTF_Encoding.UTF_16LE =>
            return Decode (Item         => TextExtern,
                           Input_Scheme => Ada.Strings.UTF_Encoding.UTF_16LE);
      end case;
      
   end Decode;
   
   
   
   function DecodeUnbounded
     (TextExtern : in String)
      return Unbounded_Wide_Wide_String
   is begin
      
      return To_Unbounded_Wide_Wide_String (Source => Decode (TextExtern => TextExtern));
      
   end DecodeUnbounded;
   
   
   
   function Encode
     (TextExtern : in Wide_Wide_String)
      return String
   is begin
      
      case
        HTB3_Umwandlungsvariablen.KodierungAbfragen
      is
         when Ada.Strings.UTF_Encoding.UTF_8 =>
            return Encode (Item          => TextExtern,
                           Output_Scheme => Ada.Strings.UTF_Encoding.UTF_8,
                           Output_BOM    => False);
            
         when Ada.Strings.UTF_Encoding.UTF_16BE =>
            return Encode (Item          => TextExtern,
                           Output_Scheme => Ada.Strings.UTF_Encoding.UTF_16BE,
                           Output_BOM    => False);
            
         when Ada.Strings.UTF_Encoding.UTF_16LE =>
            return Encode (Item          => TextExtern,
                           Output_Scheme => Ada.Strings.UTF_Encoding.UTF_16LE,
                           Output_BOM    => False);
      end case;
      
   end Encode;
   
   
   
   function EncodeUnbounded
     (TextExtern : in Unbounded_Wide_Wide_String)
      return String
   is begin
      
      return Encode (TextExtern => To_Wide_Wide_String (Source => TextExtern));
      
   end EncodeUnbounded;

end HTB3_Umwandlungssystem;

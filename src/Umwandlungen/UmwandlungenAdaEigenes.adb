with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Wide_Wide_Fixed; use Ada.Strings.Wide_Wide_Fixed;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Projekteinstellungen;
with BetriebssystemDatentypen;

with LeseOptionen;

package body UmwandlungenAdaEigenes is
   
   function ZahlAlsString
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
      
   end ZahlAlsString;
   
   
   
   function KommazahlAlsString
     (KommazahlExtern : in Kommazahl)
      return Wide_Wide_String
   is begin
      
      Put (To   => Kommazahlenstring,
           Item => Float (KommazahlExtern),
           Aft  => 2,
           Exp  => 0);
      
      return Trim (Source => PunktOderKomma (ZahlenstringExtern => EigenesDecode (TextExtern => Kommazahlenstring)),
                   Side   => Ada.Strings.Left);
      
   end KommazahlAlsString;
   
   
   
   function PunktOderKomma
     (ZahlenstringExtern : in Wide_Wide_String)
      return Wide_Wide_String
   is begin
      
      Zwischenspeicher := ZahlenstringExtern;
      
      ZahlenSchleife:
      for ZahlenSchleifenwert in Zwischenspeicher'Range loop
         
         case
           Zwischenspeicher (ZahlenSchleifenwert)
         is
            when '.' =>
               Zwischenspeicher (ZahlenSchleifenwert) := LeseOptionen.Dezimaltrennzeichen;
               exit ZahlenSchleife;
               
            when others =>
               null;
         end case;
         
      end loop ZahlenSchleife;
      
      return Zwischenspeicher;
      
   end PunktOderKomma;
   
   
   
   function EigenesDecode
     (TextExtern : in String)
      return Wide_Wide_String
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Stringkodierung
      is
         when BetriebssystemDatentypen.UTF8_Enum =>
            return Decode (Item         => TextExtern,
                           Input_Scheme => Ada.Strings.UTF_Encoding.UTF_8);
            
         when BetriebssystemDatentypen.UTF16BE_Enum =>
            return Decode (Item         => TextExtern,
                           Input_Scheme => Ada.Strings.UTF_Encoding.UTF_16BE);
            
            
         when BetriebssystemDatentypen.UTF16LE_Enum =>
            return Decode (Item         => TextExtern,
                           Input_Scheme => Ada.Strings.UTF_Encoding.UTF_16LE);
      end case;
      
   end EigenesDecode;
   
   
   
   function EigenesDecodeUnbounded
     (TextExtern : in String)
      return Unbounded_Wide_Wide_String
   is begin
      
      return To_Unbounded_Wide_Wide_String (Source => EigenesDecode (TextExtern => TextExtern));
      
   end EigenesDecodeUnbounded;
   
   
   
   function EigenesEncode
     (TextExtern : in Wide_Wide_String)
      return String
   is begin
      
      case
        Projekteinstellungen.Einstellungen.Stringkodierung
      is
         when BetriebssystemDatentypen.UTF8_Enum =>
            return Encode (Item          => TextExtern,
                           Output_Scheme => Ada.Strings.UTF_Encoding.UTF_8,
                           Output_BOM    => False);
            
         when BetriebssystemDatentypen.UTF16BE_Enum =>
            return Encode (Item          => TextExtern,
                           Output_Scheme => Ada.Strings.UTF_Encoding.UTF_16BE,
                           Output_BOM    => False);
            
         when BetriebssystemDatentypen.UTF16LE_Enum =>
            return Encode (Item          => TextExtern,
                           Output_Scheme => Ada.Strings.UTF_Encoding.UTF_16LE,
                           Output_BOM    => False);
      end case;
      
   end EigenesEncode;
   
   
   
   function EigenesEncodeUnbounded
     (TextExtern : in Unbounded_Wide_Wide_String)
      return String
   is begin
      
      return EigenesEncode (TextExtern => To_Wide_Wide_String (Source => TextExtern));
      
   end EigenesEncodeUnbounded;

end UmwandlungenAdaEigenes;

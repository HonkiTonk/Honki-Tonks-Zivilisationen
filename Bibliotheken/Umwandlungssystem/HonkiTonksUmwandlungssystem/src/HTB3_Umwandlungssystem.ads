with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package HTB3_Umwandlungssystem is
   pragma Elaborate_Body;
   
   generic type GanzeZahl is range <>;
      
   function Zahlenstring
     (ZahlExtern : in GanzeZahl)
      return Wide_Wide_String
     with
       Post => (
                  Zahlenstring'Result'Length > 0
               );
   
   generic type Kommazahl is digits <>;
      
      -- Aufgrund der Stringlänge geht das nur für die Werte -9_999_999_999,99 .. 9_999_999_999,99.
   function Kommazahlenstring
     (KommazahlExtern : in Kommazahl)
      return Wide_Wide_String
     with
       Post => (
                  Kommazahlenstring'Result'Length > 0
               );
   
   function Decode
     (TextExtern : in String)
      return Wide_Wide_String;
            
   function DecodeUnbounded
     (TextExtern : in String)
      return Unbounded_Wide_Wide_String;
   
   function Encode
     (TextExtern : in Wide_Wide_String)
      return String;
   
   function EncodeUnbounded
     (TextExtern : in Unbounded_Wide_Wide_String)
      return String;
   
private
   
   Standardtrennzeichen : constant Wide_Wide_Character := '.';
      
   -- Die Länge kommt von "-1_000_000_000,00".
   ZwischenspeicherKommazahlenstring : String (1 .. 14);
   
   Zwischenspeicher : Wide_Wide_String (ZwischenspeicherKommazahlenstring'Range);
      
   function Dezimaltrennzeichen
     (ZahlenstringExtern : in Wide_Wide_String)
      return Wide_Wide_String
     with
       Post => (
                  Dezimaltrennzeichen'Result'Length > 0
               );

end HTB3_Umwandlungssystem;

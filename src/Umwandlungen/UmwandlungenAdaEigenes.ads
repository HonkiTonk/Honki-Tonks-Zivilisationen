with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package UmwandlungenAdaEigenes is
   pragma Elaborate_Body;
   
   generic type GanzeZahl is range <>;
      
   function ZahlAlsString
     (ZahlExtern : in GanzeZahl)
      return Wide_Wide_String
     with
       Post => (
                  ZahlAlsString'Result'Length > 0
               );
   
   generic type Kommazahl is digits <>;
      
      -- Aufgrund der Stringlänge geht das maximal bis 1_000_000,00.
   function KommazahlAlsString
     (KommazahlExtern : in Kommazahl)
      return Wide_Wide_String
     with
       Post => (
                  KommazahlAlsString'Result'Length > 0
               );
   
   function EigenesDecode
     (TextExtern : in String)
      return Wide_Wide_String;
            
   function EigenesDecodeUnbounded
     (TextExtern : in String)
      return Unbounded_Wide_Wide_String;
   
   function EigenesEncode
     (TextExtern : in Wide_Wide_String)
      return String;
   
   function EigenesEncodeUnbounded
     (TextExtern : in Unbounded_Wide_Wide_String)
      return String;
   
private
   
   -- Die Länge kommt von "1_000_000,00" als maximale Bildrate, alle anderen Floatzahlen sollten kleiner sein.
   Stringlänge : constant Positive := 10;
   
   Kommazahlenstring : String (1 .. Stringlänge);
   
   Zwischenspeicher : Wide_Wide_String (Kommazahlenstring'Range);
   
   
   
   function PunktOderKomma
     (ZahlenstringExtern : in Wide_Wide_String)
      return Wide_Wide_String
     with
       Post => (
                  PunktOderKomma'Result'Length > 0
               );

end UmwandlungenAdaEigenes;

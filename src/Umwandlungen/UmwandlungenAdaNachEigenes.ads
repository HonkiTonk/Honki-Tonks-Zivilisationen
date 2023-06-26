package UmwandlungenAdaNachEigenes is
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
   
private
   
   -- Die Länge kommt von "1_000_000,00" als maximale Bildrate, alle anderen Floatzahlen sollten kleiner sein.
   Stringlänge : constant Positive := 10;
   
   Kommazahlenstring : String (1 .. Stringlänge);
   Zwischenspeicher : String (Kommazahlenstring'Range);
   
   
   
   function PunktOderKomma
     (ZahlenstringExtern : in String)
      return String
     with
       Post => (
                  PunktOderKomma'Result'Length > 0
               );

end UmwandlungenAdaNachEigenes;

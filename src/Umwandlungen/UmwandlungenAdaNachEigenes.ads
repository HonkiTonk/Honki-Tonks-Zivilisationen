with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KampfDatentypen;

package UmwandlungenAdaNachEigenes is
   pragma Elaborate_Body;
   
   generic type GanzeZahl is range <>;
      
   function ZahlAlsStringLeerzeichenEntfernen
     (ZahlExtern : in GanzeZahl)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => ZahlAlsStringLeerzeichenEntfernen'Result)'Length > 0
               );
   
   function FloatAlsString
     (KampfbonusExtern : in KampfDatentypen.Kampfbonus)
      return Wide_Wide_String
     with
       Post => (
                  FloatAlsString'Result'Length > 0
               );
   
   function PunktNachKomma
     (ZahlenstringExtern : in String)
      return String
     with
       Post => (
                  PunktNachKomma'Result'Length > 0
               );
   
private
      
   Zahlenstring : Unbounded_Wide_Wide_String;
   
   Kommazahlenstring : String (1 .. 5);
   Zwischenspeicher : String (Kommazahlenstring'Range);

end UmwandlungenAdaNachEigenes;

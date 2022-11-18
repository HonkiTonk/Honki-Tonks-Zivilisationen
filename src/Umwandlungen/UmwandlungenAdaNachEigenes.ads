with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

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
   
private
   
   UngewandelteZahl : Wide_Wide_String (1 .. 6);
   
   Zahlenstring : Unbounded_Wide_Wide_String;

end UmwandlungenAdaNachEigenes;

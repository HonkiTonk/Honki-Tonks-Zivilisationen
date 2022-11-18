with Ada.Strings.Wide_Wide_Fixed;

package body UmwandlungenAdaNachEigenes is
   
   -- Wieso Unbounded_Wide_Wide_String? Müsste Wide_Wide_String nicht auch gehen? Wenn nicht dann mal eine Wide_Wide_String Variante bauen. äöü
   function ZahlAlsStringLeerzeichenEntfernen
     (ZahlExtern : in GanzeZahl)
      return Unbounded_Wide_Wide_String
   is begin
      
      if
        ZahlExtern >= 0
      then
         Zahlenstring := To_Unbounded_Wide_Wide_String (Source => Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlExtern'Wide_Wide_Image,
                                                                                                    Side   => Ada.Strings.Left));
         
      else
         Zahlenstring := To_Unbounded_Wide_Wide_String (Source => ZahlExtern'Wide_Wide_Image);
      end if;
      
      return Zahlenstring;
      
   end ZahlAlsStringLeerzeichenEntfernen;

end UmwandlungenAdaNachEigenes;

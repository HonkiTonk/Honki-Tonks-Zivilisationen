pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Fixed;

package body UmwandlungenAdaNachEigenes is
   
   function BewegungspunkteDarstellungNormal
     (KommazahlExtern : in EinheitStadtDatentypen.BewegungFloat)
      return Unbounded_Wide_Wide_String
   is begin
            
      -- Das To => ist ein Wide_Wide_String mit out.
      AnzeigeFloatUmwandeln.Put (To   => UngewandelteZahl,
                                 Item => KommazahlExtern,
                                 Aft  => 2,
                                 Exp  => 0);
      
      return To_Unbounded_Wide_Wide_String (Source => Ada.Strings.Wide_Wide_Fixed.Trim (Source => UngewandelteZahl,
                                                                                        Side   => Ada.Strings.Left));
      
   end BewegungspunkteDarstellungNormal;
   
   
   
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

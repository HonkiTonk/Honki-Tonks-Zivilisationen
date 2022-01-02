pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Wide_Wide_Text_IO;

with EinheitStadtDatentypen;

package UmwandlungenAdaNachEigenes is

   function BewegungspunkteDarstellungNormal
     (KommazahlExtern : in EinheitStadtDatentypen.BewegungFloat)
      return Unbounded_Wide_Wide_String;
   
   generic type GanzeZahl is range <>;
   
   function ZahlAlsStringLeerzeichenEntfernen
     (ZahlExtern : in GanzeZahl)
      return Unbounded_Wide_Wide_String;
   
private
   
   UngewandelteZahl : Wide_Wide_String (1 .. 6);
   
   Zahlenstring : Unbounded_Wide_Wide_String;
   
   package AnzeigeFloatUmwandeln is new Ada.Wide_Wide_Text_IO.Float_IO (EinheitStadtDatentypen.BewegungFloat);

end UmwandlungenAdaNachEigenes;

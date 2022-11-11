with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Ada.Wide_Wide_Text_IO;

with EinheitenDatentypen;

package UmwandlungenAdaNachEigenes is
   pragma Elaborate_Body;

   function BewegungspunkteDarstellungNormal
     (KommazahlExtern : in EinheitenDatentypen.BewegungFloat)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => BewegungspunkteDarstellungNormal'Result)'Length > 0
               );
   
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
   
   package AnzeigeFloatUmwandeln is new Ada.Wide_Wide_Text_IO.Float_IO (EinheitenDatentypen.BewegungFloat);
   
   -- Merkhilfe
   -- function ZahlAlsStringMaximaleEinheitenMitNullWert is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => EinheitenDatentypen.MaximaleEinheitenMitNullWert);

end UmwandlungenAdaNachEigenes;

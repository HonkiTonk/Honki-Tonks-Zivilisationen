pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with EinheitStadtDatentypen;

package UmwandlungenAdaNachEigenes is

   function BewegungspunkteImageNachNormal
     (KommazahlExtern : in EinheitStadtDatentypen.BewegungFloat)
      return Unbounded_Wide_Wide_String;
   
private
   
   UngewandelteZahl : String (1 .. 6);
   
   RückgabeZahl : Unbounded_Wide_Wide_String;

end UmwandlungenAdaNachEigenes;

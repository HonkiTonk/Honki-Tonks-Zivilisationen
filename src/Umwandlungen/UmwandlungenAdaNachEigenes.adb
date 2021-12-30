pragma SPARK_Mode (On);

-- with Ada.Wide_Wide_Characters; use Ada.Wide_Wide_Characters;
with Ada.Float_Text_IO;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;

package body UmwandlungenAdaNachEigenes is
   
   function BewegungspunkteImageNachNormal
     (KommazahlExtern : in EinheitStadtDatentypen.BewegungFloat)
      return Unbounded_Wide_Wide_String
   is begin
      
      Ada.Float_Text_IO.Put (To   => UngewandelteZahl,
                             Item => Float (KommazahlExtern),
                             Aft  => 2,
                             Exp  => 0);
            
      return To_Unbounded_Wide_Wide_String (Source => KommazahlExtern'Wide_Wide_Image);
      
   end BewegungspunkteImageNachNormal;

end UmwandlungenAdaNachEigenes;

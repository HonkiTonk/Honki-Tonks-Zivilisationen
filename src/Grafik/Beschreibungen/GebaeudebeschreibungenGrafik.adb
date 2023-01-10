with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Speziestexte;

package body GebaeudebeschreibungenGrafik is

   function Kurzbeschreibung
     (IDExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.Gebäude (SpeziesExtern, IDExtern, 1));
      
   end Kurzbeschreibung;
   
   
   
   function Langbeschreibung
     (IDExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.Gebäude (SpeziesExtern, IDExtern, 2));
      
   end Langbeschreibung;

end GebaeudebeschreibungenGrafik;

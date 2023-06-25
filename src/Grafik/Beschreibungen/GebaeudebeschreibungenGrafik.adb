with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Speziestexte;
with TextnummernKonstanten;

package body GebaeudebeschreibungenGrafik is

   function Kurzbeschreibung
     (IDExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.Gebäude (SpeziesExtern, IDExtern, TextnummernKonstanten.KurzeBeschreibung));
      
   end Kurzbeschreibung;
   
   
   
   function Langbeschreibung
     (IDExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.Gebäude (SpeziesExtern, IDExtern, TextnummernKonstanten.LangeBeschreibung));
      
   end Langbeschreibung;

end GebaeudebeschreibungenGrafik;

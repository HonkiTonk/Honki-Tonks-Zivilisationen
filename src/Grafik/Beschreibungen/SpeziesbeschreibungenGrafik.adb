with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Speziestexte;
with TextnummernKonstanten;

package body SpeziesbeschreibungenGrafik is

   function Kurzbeschreibung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.NameBeschreibung (SpeziesExtern, TextnummernKonstanten.KurzeBeschreibung));
      
   end Kurzbeschreibung;
   
   
   
   function Langbeschreibung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.NameBeschreibung (SpeziesExtern, TextnummernKonstanten.LangeBeschreibung));
      
   end Langbeschreibung;

end SpeziesbeschreibungenGrafik;

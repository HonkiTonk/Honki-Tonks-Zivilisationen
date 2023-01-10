with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Speziestexte;

package body SpeziesbeschreibungenGrafik is

   -- Die beiden Funktionen verschmelzen und die Zeile von außen hinein geben? äöü
   -- Oder getrennt lassen und nur für die BeschreibungLang die Zeile hinein geben? äöü
   -- Diese Fragen sind auch für alle anderen Beschreibungen gültig. äöü
   function Kurzbeschreibung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.NameBeschreibung (SpeziesExtern, 1));
      
   end Kurzbeschreibung;
   
   
   
   function Langbeschreibung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.NameBeschreibung (SpeziesExtern, 2));
      
   end Langbeschreibung;

end SpeziesbeschreibungenGrafik;

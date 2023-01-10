with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleTexte;
with Speziestexte;
with TextKonstanten;
with EinheitenKonstanten;

package body EinheitenbeschreibungenGrafik is

   function Kurzbeschreibung
     (IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
          
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return TextKonstanten.LeerString;
            
         when others =>
            return To_Wide_Wide_String (Source => Speziestexte.Einheiten (SpeziesExtern, IDExtern, 1));
      end case;
         
   end Kurzbeschreibung;
   
   
   
   function Langbeschreibung
     (IDExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.Einheiten (SpeziesExtern, IDExtern, 2));
      
   end Langbeschreibung;
   
   
   
   function KurzbeschreibungBeschäftigung
     (ArbeitExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => GlobaleTexte.Beschäftigungen (2 * AufgabenDatentypen.Einheiten_Aufgaben_Enum'Pos (ArbeitExtern) + 1));
      
   end KurzbeschreibungBeschäftigung;
   
   
   
   function LangbeschreibungBeschäftigung
     (ArbeitExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => GlobaleTexte.Beschäftigungen (2 * AufgabenDatentypen.Einheiten_Aufgaben_Enum'Pos (ArbeitExtern)));
      
   end LangbeschreibungBeschäftigung;

end EinheitenbeschreibungenGrafik;

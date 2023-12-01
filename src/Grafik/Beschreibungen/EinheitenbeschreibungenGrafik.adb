with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Spieltexte;
with Speziestexte;
with TextKonstanten;
with EinheitenKonstanten;
with TextnummernKonstanten;

package body EinheitenbeschreibungenGrafik is

   function Kurzbeschreibung
     (IDExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
          
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return TextKonstanten.LeerString;
            
         when others =>
            return To_Wide_Wide_String (Source => Speziestexte.Einheiten (SpeziesExtern, IDExtern, TextnummernKonstanten.KurzeBeschreibung));
      end case;
         
   end Kurzbeschreibung;
   
   
   
   function Langbeschreibung
     (IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.Einheiten (SpeziesExtern, IDExtern, TextnummernKonstanten.LangeBeschreibung));
      
   end Langbeschreibung;
   
   
   
   function KurzbeschreibungBeschäftigung
     (ArbeitExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Spieltexte.Beschäftigungen (2 * AufgabenDatentypen.Einheiten_Aufgaben_Enum'Pos (ArbeitExtern) + 1));
      
   end KurzbeschreibungBeschäftigung;
   
   
   
   function LangbeschreibungBeschäftigung
     (ArbeitExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Spieltexte.Beschäftigungen (2 * AufgabenDatentypen.Einheiten_Aufgaben_Enum'Pos (ArbeitExtern)));
      
   end LangbeschreibungBeschäftigung;

end EinheitenbeschreibungenGrafik;

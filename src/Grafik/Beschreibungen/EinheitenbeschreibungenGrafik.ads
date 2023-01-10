with EinheitenDatentypen;
with AufgabenDatentypen;
with SpeziesDatentypen;

package EinheitenbeschreibungenGrafik is
   pragma Elaborate_Body;
   
   function Kurzbeschreibung
     (IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String;
   
   function Langbeschreibung
     (IDExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String;
   
   function KurzbeschreibungBeschäftigung
     (ArbeitExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
      return Wide_Wide_String;
   
   function LangbeschreibungBeschäftigung
     (ArbeitExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
      return Wide_Wide_String;
   
end EinheitenbeschreibungenGrafik;

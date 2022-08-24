pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen;
with AufgabenDatentypen;

package EinheitenbeschreibungenSFML is
   
   function BeschreibungKurz
     (IDExtern : in EinheitenDatentypen.EinheitenID)
      return Wide_Wide_String;
   
   function BeschreibungLang
     (IDExtern : in EinheitenDatentypen.EinheitenID)
      return Wide_Wide_String;
   
   function Beschäftigung
     (ArbeitExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
      return Wide_Wide_String;
   
end EinheitenbeschreibungenSFML;

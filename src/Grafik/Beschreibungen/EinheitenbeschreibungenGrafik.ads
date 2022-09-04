pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen;
with AufgabenDatentypen;
with RassenDatentypen;

package EinheitenbeschreibungenGrafik is
   
   function BeschreibungKurz
     (IDExtern : in EinheitenDatentypen.EinheitenID;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String;
   
   function BeschreibungLang
     (IDExtern : in EinheitenDatentypen.EinheitenID;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String;
   
   function Beschäftigung
     (ArbeitExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
      return Wide_Wide_String;
   
end EinheitenbeschreibungenGrafik;

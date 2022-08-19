pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleTexte;

package body EinheitenbeschreibungenSFML is

   function BeschreibungKurz
     (IDExtern : in EinheitenDatentypen.EinheitenID)
      return Wide_Wide_String
   is begin
          
      return To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (IDExtern) - 1));
         
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (IDExtern : in EinheitenDatentypen.EinheitenID)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => GlobaleTexte.Einheiten (2 * Positive (IDExtern)));
      
   end BeschreibungLang;
   
   
   
   function Beschäftigung
     (ArbeitExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => GlobaleTexte.Beschäftigungen (2 * AufgabenDatentypen.Einheiten_Aufgaben_Enum'Pos (ArbeitExtern) + 1));
      
   end Beschäftigung;

end EinheitenbeschreibungenSFML;

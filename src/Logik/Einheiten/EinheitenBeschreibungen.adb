pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleTexte;

package body EinheitenBeschreibungen is

   function BeschreibungKurz
     (IDExtern : in EinheitenDatentypen.EinheitenID)
      return Wide_Wide_String
   is begin
          
      Textnummer := 2 * Positive (IDExtern) - 1;
               
      BeschreibungText := GlobaleTexte.Einheiten (Textnummer);
      
      return To_Wide_Wide_String (Source => BeschreibungText);
         
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (IDExtern : in EinheitenDatentypen.EinheitenID)
      return Wide_Wide_String
   is begin
      
      Textnummer := 2 * Positive (IDExtern);
               
      BeschreibungText := GlobaleTexte.Einheiten (Textnummer);
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungLang;
   
   
   
   function Beschäftigung
     (ArbeitExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
      return Wide_Wide_String
   is begin
      
      BeschäftigungText := GlobaleTexte.Beschäftigungen (2 * AufgabenDatentypen.Einheiten_Aufgaben_Enum'Pos (ArbeitExtern) + 1);
         
      return To_Wide_Wide_String (Source => BeschäftigungText);
      
   end Beschäftigung;

end EinheitenBeschreibungen;

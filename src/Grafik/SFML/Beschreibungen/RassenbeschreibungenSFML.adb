pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleTexte;

package body RassenbeschreibungenSFML is

   function BeschreibungKurz
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => GlobaleTexte.Rassen (2 * RassenDatentypen.Rassen_Enum'Pos (RasseExtern) - 1));
      
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => GlobaleTexte.Rassen (2 * RassenDatentypen.Rassen_Enum'Pos (RasseExtern)));
      
   end BeschreibungLang;

end RassenbeschreibungenSFML;

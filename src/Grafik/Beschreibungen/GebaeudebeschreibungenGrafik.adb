pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Rassentexte;

package body GebaeudebeschreibungenGrafik is

   function BeschreibungKurz
     (IDExtern : in StadtDatentypen.GebäudeID;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Rassentexte.Gebäude (RasseExtern, IDExtern, 1));
      
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (IDExtern : in StadtDatentypen.GebäudeID;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Rassentexte.Gebäude (RasseExtern, IDExtern, 2));
      
   end BeschreibungLang;

end GebaeudebeschreibungenGrafik;

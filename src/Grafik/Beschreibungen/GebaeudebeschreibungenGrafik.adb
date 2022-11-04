pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Rassentexte;

package body GebaeudebeschreibungenGrafik is

   function Kurzbeschreibung
     (IDExtern : in StadtDatentypen.GebäudeID;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Rassentexte.Gebäude (RasseExtern, IDExtern, 1));
      
   end Kurzbeschreibung;
   
   
   
   function Langbeschreibung
     (IDExtern : in StadtDatentypen.GebäudeID;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Rassentexte.Gebäude (RasseExtern, IDExtern, 2));
      
   end Langbeschreibung;

end GebaeudebeschreibungenGrafik;

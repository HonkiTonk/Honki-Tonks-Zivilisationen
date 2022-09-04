pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Rassentexte;

package body RassenbeschreibungenGrafik is

   -- Die beiden Funktionen verschmelzen und die Zeile von außen hinein geben? äöü
   -- Oder getrennt lassen und nur für die BeschreibungLang die Zeile hinein geben? äöü
   -- Diese Fragen sind auch für alle anderen Beschreibungen gültig. äöü
   function BeschreibungKurz
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Rassentexte.NameBeschreibung (RasseExtern, 1));
      
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Rassentexte.NameBeschreibung (RasseExtern, 2));
      
   end BeschreibungLang;

end RassenbeschreibungenGrafik;

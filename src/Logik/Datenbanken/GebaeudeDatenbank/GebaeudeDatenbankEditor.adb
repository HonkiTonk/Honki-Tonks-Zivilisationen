pragma SPARK_Mode (On);

with GebaeudeDatenbank;

with SchreibenDatenbanken;

package body GebaeudeDatenbankEditor is

   procedure GebaeudeDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenGebäudeDatenbank;
      
   end GebaeudeDatenbankSpeichern;

end GebaeudeDatenbankEditor;

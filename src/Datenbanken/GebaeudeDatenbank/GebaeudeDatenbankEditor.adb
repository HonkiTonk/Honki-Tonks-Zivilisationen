pragma SPARK_Mode (On);

with GebaeudeDatenbank, SchreibenDatenbanken;

package body GebaeudeDatenbankEditor is

   procedure GebaeudeDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenGebäudeDatenbank;
      
   end GebaeudeDatenbankSpeichern;

end GebaeudeDatenbankEditor;

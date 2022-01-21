pragma SPARK_Mode (On);

-- with GebaeudeDatenbank;

with SchreibenDatenbanken;

package body GebaeudeDatenbankEditor is
   
   procedure GebäudeDatenbankEditor
   is begin
      
      null;
      
   end GebäudeDatenbankEditor;
   
   

   procedure GebäudeDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenGebäudeDatenbank;
      
   end GebäudeDatenbankSpeichern;

end GebaeudeDatenbankEditor;

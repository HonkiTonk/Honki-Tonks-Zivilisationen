pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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

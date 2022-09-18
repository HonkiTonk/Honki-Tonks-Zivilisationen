pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with GebaeudeDatenbank;

with SchreibenDatenbankenLogik;

package body GebaeudeDatenbankeditorLogik is
   
   procedure GebäudeDatenbankEditor
   is begin
      
      null;
      
   end GebäudeDatenbankEditor;
   
   

   procedure GebäudeDatenbankSpeichern
   is begin
      
      SchreibenDatenbankenLogik.SchreibenGebäudeDatenbank;
      
   end GebäudeDatenbankSpeichern;

end GebaeudeDatenbankeditorLogik;

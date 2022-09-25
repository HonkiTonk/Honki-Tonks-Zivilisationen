pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibenDatenbankenLogik;

package body VerbesserungenDatenbank is
   
   procedure StandardVerbesserungenDatenbankLaden
   is begin
      
      Verbesserungenliste := VerbesserungenlisteStandard;
      
   end StandardVerbesserungenDatenbankLaden;
   
   
   
   procedure StandardWegeDatenbankLaden
   is begin
      
      Wegeliste := WegelisteStandard;
      
   end StandardWegeDatenbankLaden;
   
   

   procedure VerbesserungenDatenbankSpeichern
   is begin
      
      SchreibenDatenbankenLogik.SchreibenVerbesserungenDatenbank;
      
   end VerbesserungenDatenbankSpeichern;
   
end VerbesserungenDatenbank;

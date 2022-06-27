pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body VerbesserungenDatenbank is
   
   procedure StandardVerbesserungenDatenbankLaden
   is begin
      
      Verbesserungenliste := VerbesserungenlisteStandard;
      
   end StandardVerbesserungenDatenbankLaden;
   
   
   
   procedure StandardWegeDatenbankLaden
   is begin
      
      Wegeliste := WegelisteStandard;
      
   end StandardWegeDatenbankLaden;
   
end VerbesserungenDatenbank;

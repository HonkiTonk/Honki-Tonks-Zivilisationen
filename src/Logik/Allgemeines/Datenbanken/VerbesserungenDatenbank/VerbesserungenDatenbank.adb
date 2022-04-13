pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body VerbesserungenDatenbank is
   
   procedure StandardVerbesserungenDatenbankLaden
   is begin
      
      VerbesserungenListe := VerbesserungenListeStandard;
      
   end StandardVerbesserungenDatenbankLaden;
   
   
   
   procedure StandardWegeDatenbankLaden
   is begin
      
      WegeListe := WegeListeStandard;
      
   end StandardWegeDatenbankLaden;
   
end VerbesserungenDatenbank;

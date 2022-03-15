pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body VerbesserungenDatenbank is
   
   procedure StandardVerbesserungenDatenbankLaden
   is begin
      
      VerbesserungListe := VerbesserungListeStandard;
      
   end StandardVerbesserungenDatenbankLaden;
   
end VerbesserungenDatenbank;

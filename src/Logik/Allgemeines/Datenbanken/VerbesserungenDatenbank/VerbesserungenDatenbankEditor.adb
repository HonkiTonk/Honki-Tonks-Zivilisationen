pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with VerbesserungenDatenbank;

with SchreibenDatenbanken;

package body VerbesserungenDatenbankEditor is
   
   procedure VerbesserungenDatenbankEditor
   is begin
      
      null;
      
   end VerbesserungenDatenbankEditor;
   
   

   procedure VerbesserungenDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenVerbesserungenDatenbank;
      
   end VerbesserungenDatenbankSpeichern;

end VerbesserungenDatenbankEditor;

pragma SPARK_Mode (On);

with VerbesserungenDatenbank, SchreibenDatenbanken;

package body VerbesserungenDatenbankEditor is

   procedure VerbesserungenDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenVerbesserungenDatenbank;
      
   end VerbesserungenDatenbankSpeichern;

end VerbesserungenDatenbankEditor;

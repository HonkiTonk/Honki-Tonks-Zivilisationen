pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with VerbesserungenDatenbank;

with SchreibenDatenbankenLogik;

package body VerbesserungenDatenbankeditorLogik is
   
   procedure VerbesserungenDatenbankEditor
   is begin
      
      null;
      
   end VerbesserungenDatenbankEditor;
   
   

   procedure VerbesserungenDatenbankSpeichern
   is begin
      
      SchreibenDatenbankenLogik.SchreibenVerbesserungenDatenbank;
      
   end VerbesserungenDatenbankSpeichern;

end VerbesserungenDatenbankeditorLogik;

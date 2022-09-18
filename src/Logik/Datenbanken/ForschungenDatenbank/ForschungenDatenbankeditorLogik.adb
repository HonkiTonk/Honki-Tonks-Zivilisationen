pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with ForschungenDatenbank;

with SchreibenDatenbankenLogik;

package body ForschungenDatenbankeditorLogik is
   
   procedure ForschungenDatenbankEditor
   is begin
      
      null;
      
   end ForschungenDatenbankEditor;
   
   

   procedure ForschungenDatenbankSpeichern
   is begin
      
      SchreibenDatenbankenLogik.SchreibenForschungenDatenbank;
      
   end ForschungenDatenbankSpeichern;

end ForschungenDatenbankeditorLogik;

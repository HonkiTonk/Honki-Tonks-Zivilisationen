pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with ForschungenDatenbank;

with SchreibenDatenbanken;

package body ForschungenDatenbankEditor is
   
   procedure ForschungenDatenbankEditor
   is begin
      
      null;
      
   end ForschungenDatenbankEditor;
   
   

   procedure ForschungenDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenForschungenDatenbank;
      
   end ForschungenDatenbankSpeichern;

end ForschungenDatenbankEditor;

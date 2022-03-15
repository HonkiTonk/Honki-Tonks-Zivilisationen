pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with ForschungsDatenbank;

with SchreibenDatenbanken;

package body ForschungDatenbankEditor is
   
   procedure ForschungDatenbankEditor
   is begin
      
      null;
      
   end ForschungDatenbankEditor;
   
   

   procedure ForschungDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenForschungsDatenbank;
      
   end ForschungDatenbankSpeichern;

end ForschungDatenbankEditor;

pragma SPARK_Mode (On);

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

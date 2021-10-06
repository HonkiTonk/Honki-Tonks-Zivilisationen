pragma SPARK_Mode (On);

with ForschungsDatenbank;

with SchreibenDatenbanken;

package body ForschungDatenbankEditor is

   procedure ForschungDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenForschungsDatenbank;
      
   end ForschungDatenbankSpeichern;

end ForschungDatenbankEditor;

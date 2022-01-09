pragma SPARK_Mode (On);

with KartenDatenbank;

with SchreibenDatenbanken;

package body KartenDatenbankEditor is

   procedure KartenDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenKartenDatenbank;
      
   end KartenDatenbankSpeichern;

end KartenDatenbankEditor;

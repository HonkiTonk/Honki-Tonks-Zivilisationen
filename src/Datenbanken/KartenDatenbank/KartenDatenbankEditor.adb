pragma SPARK_Mode (On);

with KartenDatenbank, SchreibenDatenbanken;

package body KartenDatenbankEditor is

   procedure KartenDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenKartenDatenbank;
      
   end KartenDatenbankSpeichern;

end KartenDatenbankEditor;

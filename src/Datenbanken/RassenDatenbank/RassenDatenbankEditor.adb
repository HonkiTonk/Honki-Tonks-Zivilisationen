pragma SPARK_Mode (On);

with RassenDatenbank, SchreibenDatenbanken;

package body RassenDatenbankEditor is

   procedure RassenDatenbankSpeichern
   is begin

      SchreibenDatenbanken.SchreibenRassenDatenbank;

   end RassenDatenbankSpeichern;

end RassenDatenbankEditor;
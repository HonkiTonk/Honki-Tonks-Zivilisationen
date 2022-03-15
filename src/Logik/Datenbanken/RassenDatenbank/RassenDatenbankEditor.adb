pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatenbank;

with SchreibenDatenbanken;

package body RassenDatenbankEditor is

   procedure RassenDatenbankSpeichern
   is begin

      SchreibenDatenbanken.SchreibenRassenDatenbank;

   end RassenDatenbankSpeichern;

end RassenDatenbankEditor;

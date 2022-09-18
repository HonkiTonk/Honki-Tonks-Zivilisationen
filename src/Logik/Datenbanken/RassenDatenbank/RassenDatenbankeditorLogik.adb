pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatenbank;

with SchreibenDatenbanken;

package body RassenDatenbankeditorLogik is

   procedure RassenDatenbankSpeichern
   is begin

      SchreibenDatenbanken.SchreibenRassenDatenbank;

   end RassenDatenbankSpeichern;

end RassenDatenbankeditorLogik;

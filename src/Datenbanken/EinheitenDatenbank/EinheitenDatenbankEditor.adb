pragma SPARK_Mode (On);

with EinheitenDatenbank, SchreibenDatenbanken;

package body EinheitenDatenbankEditor is

   procedure EinheitenDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenEinheitenDatenbank;
      
   end EinheitenDatenbankSpeichern;

end EinheitenDatenbankEditor;
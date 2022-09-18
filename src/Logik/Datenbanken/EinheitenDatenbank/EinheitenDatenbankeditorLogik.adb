pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with EinheitenDatenbank;

with SchreibenDatenbankenLogik;

package body EinheitenDatenbankeditorLogik is
   
   procedure EinheitenDatenbankEditor
   is begin
      
      null;
      
   end EinheitenDatenbankEditor;
   
   

   procedure EinheitenDatenbankSpeichern
   is begin
      
      SchreibenDatenbankenLogik.SchreibenEinheitenDatenbank;
      
   end EinheitenDatenbankSpeichern;

end EinheitenDatenbankeditorLogik;

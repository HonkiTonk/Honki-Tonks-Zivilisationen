pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with EinheitenDatenbank;

with SchreibenDatenbanken;

package body EinheitenDatenbankEditor is
   
   procedure EinheitenDatenbankEditor
   is begin
      
      null;
      
   end EinheitenDatenbankEditor;
   
   

   procedure EinheitenDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenEinheitenDatenbank;
      
   end EinheitenDatenbankSpeichern;

end EinheitenDatenbankEditor;

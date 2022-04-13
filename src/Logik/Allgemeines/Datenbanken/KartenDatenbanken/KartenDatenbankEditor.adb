pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with KartenDatenbank;

with SchreibenDatenbanken;

package body KartenDatenbankEditor is
   
   procedure KartenDatenbankEditor
   is begin
      
      null;
      
   end KartenDatenbankEditor;
   
   

   procedure KartenDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenKartenDatenbank;
      
   end KartenDatenbankSpeichern;

end KartenDatenbankEditor;

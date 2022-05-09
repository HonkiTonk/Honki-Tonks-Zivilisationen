pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with KartengrundDatenbank;

with SchreibenDatenbanken;

package body KartenDatenbankenEditor is
   
   procedure KartenDatenbankenEditor
   is begin
      
      null;
      
   end KartenDatenbankenEditor;
   
   

   procedure KartengrundDatenbankSpeichern
   is begin
      
      SchreibenDatenbanken.SchreibenKartenDatenbanken;
      
   end KartengrundDatenbankSpeichern;

end KartenDatenbankenEditor;

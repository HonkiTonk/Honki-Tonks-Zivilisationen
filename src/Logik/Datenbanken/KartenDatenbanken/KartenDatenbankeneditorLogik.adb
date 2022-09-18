pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with KartengrundDatenbank;

with SchreibenDatenbankenLogik;

package body KartenDatenbankeneditorLogik is
   
   procedure KartenDatenbankenEditor
   is begin
      
      null;
      
   end KartenDatenbankenEditor;
   
   

   procedure KartengrundDatenbankSpeichern
   is begin
      
      SchreibenDatenbankenLogik.SchreibenKartenDatenbanken;
      
   end KartengrundDatenbankSpeichern;

end KartenDatenbankeneditorLogik;

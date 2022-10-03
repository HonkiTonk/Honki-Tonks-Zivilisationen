pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungVariablen;
with VerzeichnisKonstanten;

package body SchreibenTastaturLogik is

   procedure TastenbelegungSchreiben
   is begin
      
      Create (File => TastenbelegungSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Tastenbelegung);
      
      TastenbelegungVariablen.TastenbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                                         TastenbelegungVariablen.Tastenbelegung);
      
      Close (File => TastenbelegungSpeichern);
      
   end TastenbelegungSchreiben;

end SchreibenTastaturLogik;

pragma Warnings (Off, "*array aggregate*");

with TastenbelegungVariablen;
with VerzeichnisKonstanten;

package body SchreibenTastaturLogik is

   procedure TastenbelegungSchreiben
   is begin
      
      Create (File => TastenbelegungSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Tastenbelegung);
      
      TastenbelegungVariablen.AllgemeineBelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                                             TastenbelegungVariablen.AllgemeineBelegung);
      
      TastenbelegungVariablen.EinheitenbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                                            TastenbelegungVariablen.Einheitenbelegung);
      
      TastenbelegungVariablen.StadtbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                                        TastenbelegungVariablen.Stadtbelegung);
      
      Close (File => TastenbelegungSpeichern);
      
   end TastenbelegungSchreiben;

end SchreibenTastaturLogik;

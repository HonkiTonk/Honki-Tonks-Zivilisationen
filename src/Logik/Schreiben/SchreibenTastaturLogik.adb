with VerzeichnisKonstanten;
with TastenbelegungDatenbank;

package body SchreibenTastaturLogik is

   procedure TastenbelegungSchreiben
   is begin
      
      Create (File => TastenbelegungSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.Tastenbelegung,
              Form => "WCEM=8");
      
      TastenbelegungDatenbank.AllgemeineBelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                                             TastenbelegungDatenbank.AllgemeineBelegung);
      
      TastenbelegungDatenbank.EinheitenbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                                            TastenbelegungDatenbank.Einheitenbelegung);
      
      TastenbelegungDatenbank.StadtbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                                        TastenbelegungDatenbank.Stadtbelegung);
      
      Close (File => TastenbelegungSpeichern);
      
   end TastenbelegungSchreiben;

end SchreibenTastaturLogik;

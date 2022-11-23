with Ada.Directories; use Ada.Directories;

with TastenbelegungDatenbank;
with VerzeichnisKonstanten;
with StandardTastenbelegungDatenbank;

package body EinlesenTastaturLogik is

   procedure EinlesenTastaturbelegung
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Tastenbelegung)
      is
         when True =>
            Open (File => TastenbelegungLaden,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Tastenbelegung);
      
            TastenbelegungDatenbank.AllgemeineBelegungArray'Read (Stream (File => TastenbelegungLaden),
                                                                  TastenbelegungDatenbank.AllgemeineBelegung);
      
            TastenbelegungDatenbank.EinheitenbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                                                 TastenbelegungDatenbank.Einheitenbelegung);
      
            TastenbelegungDatenbank.StadtbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                                             TastenbelegungDatenbank.Stadtbelegung);
      
            Close (File => TastenbelegungLaden);

         when False =>
            StandardTastenbelegungDatenbank.StandardTastenbelegungLaden;
      end case;
      
   end EinlesenTastaturbelegung;

end EinlesenTastaturLogik;

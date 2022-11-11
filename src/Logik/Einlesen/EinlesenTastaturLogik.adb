with Ada.Directories; use Ada.Directories;

with TastenbelegungVariablen;
with VerzeichnisKonstanten;

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
      
            TastenbelegungVariablen.AllgemeineBelegungArray'Read (Stream (File => TastenbelegungLaden),
                                                                  TastenbelegungVariablen.AllgemeineBelegung);
      
            TastenbelegungVariablen.EinheitenbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                                                 TastenbelegungVariablen.Einheitenbelegung);
      
            TastenbelegungVariablen.StadtbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                                             TastenbelegungVariablen.Stadtbelegung);
      
            Close (File => TastenbelegungLaden);

         when False =>
            TastenbelegungVariablen.StandardTastenbelegungLaden;
      end case;
      
   end EinlesenTastaturbelegung;

end EinlesenTastaturLogik;

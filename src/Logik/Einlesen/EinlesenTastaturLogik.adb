pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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

         when False =>
            TastenbelegungVariablen.StandardTastenbelegungLaden;
            return;
      end case;
      
      TastenbelegungVariablen.TastenbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                                        TastenbelegungVariablen.Tastenbelegung);
      
      Close (File => TastenbelegungLaden);
      
   end EinlesenTastaturbelegung;

end EinlesenTastaturLogik;

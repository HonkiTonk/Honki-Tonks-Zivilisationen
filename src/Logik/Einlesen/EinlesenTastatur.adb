pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with TastenbelegungVariablen;

package body EinlesenTastatur is

   procedure EinlesenTastaturbelegung
   is begin
      
      case
        Exists (Name => "Tastenbelegung")
      is
         when True =>
            Open (File => TastenbelegungLaden,
                  Mode => In_File,
                  Name => "Tastenbelegung");

         when False =>
            TastenbelegungVariablen.StandardTastenbelegungLaden;
            return;
      end case;
      
      TastenbelegungVariablen.TastenbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                                        TastenbelegungVariablen.Tastenbelegung);
      
      Close (File => TastenbelegungLaden);
      
   end EinlesenTastaturbelegung;

end EinlesenTastatur;

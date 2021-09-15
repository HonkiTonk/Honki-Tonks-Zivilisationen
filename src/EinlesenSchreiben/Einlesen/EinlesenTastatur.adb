pragma SPARK_Mode (On);

with Ada.Directories;
use Ada.Directories;

with Eingabe;

package body EinlesenTastatur is

   procedure EinlesenTastaturbelegung
   is begin
      
      case
        Exists (Name => "Einstellungen/Tastenbelegung")
      is
         when True =>
            Open (File => TastenbelegungLaden,
                  Mode => In_File,
                  Name => "Einstellungen/Tastenbelegung");

         when False =>
            Eingabe.StandardTastenbelegungLaden;
            return;
      end case;
      
      Eingabe.TastenbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                        Eingabe.Tastenbelegung);
      
      Close (File => TastenbelegungLaden);
      
   end EinlesenTastaturbelegung;

end EinlesenTastatur;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with EingabeSFML;

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
            EingabeSFML.StandardTastenbelegungLaden;
            return;
      end case;
      
      EingabeSFML.TastenbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                            EingabeSFML.Tastenbelegung);
      
      Close (File => TastenbelegungLaden);
      
   end EinlesenTastaturbelegung;

end EinlesenTastatur;

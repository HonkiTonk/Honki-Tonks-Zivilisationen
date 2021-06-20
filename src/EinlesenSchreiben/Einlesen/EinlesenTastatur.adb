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
            return;
      end case;
      
      BelegungFeldSchleife:
      for BelegungFeldSchleifenwert in Eingabe.TastenbelegungArray'Range (1) loop
         BelegungPositionSchleife:
         for BelegungPositionSchleifenwert in Eingabe.TastenbelegungArray'Range (2) loop
            
            Wide_Wide_Character'Read (Stream (File => TastenbelegungLaden),
                                      Eingabe.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert));
            
         end loop BelegungPositionSchleife;
      end loop BelegungFeldSchleife;
      
      Close (File => TastenbelegungLaden);
      
   end EinlesenTastaturbelegung;

end EinlesenTastatur;

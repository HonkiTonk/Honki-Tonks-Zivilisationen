pragma SPARK_Mode (On);

with Ada.Directories;
use Ada.Directories;

with Eingabe;

package body SchreibenTastatur is

   procedure TastenbelegungSchreiben
   is begin
      
      case
        Exists (Name => "Einstellungen/Tastenbelegung")
      is
         when True =>   
            Open (File => TastenbelegungSpeichern,
                  Mode => Out_File,
                  Name => "Einstellungen/Tastenbelegung");
            
         when False =>
            Create (File => TastenbelegungSpeichern,
                    Mode => Out_File,
                    Name => "Einstellungen/Tastenbelegung");
      end case;
      
      BelegungFeldSchleife:
      for BelegungFeldSchleifenwert in Eingabe.TastenbelegungArray'Range (1) loop
         BelegungPositionSchleife:
         for BelegungPositionSchleifenwert in Eingabe.TastenbelegungArray'Range (2) loop
            
            Wide_Wide_Character'Write (Stream (File => TastenbelegungSpeichern),
                                       Eingabe.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert));
            
         end loop BelegungPositionSchleife;
      end loop BelegungFeldSchleife;
      
      Close (File => TastenbelegungSpeichern);
      
   end TastenbelegungSchreiben;

end SchreibenTastatur;

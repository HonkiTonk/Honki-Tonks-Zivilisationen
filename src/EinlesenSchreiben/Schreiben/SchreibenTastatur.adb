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
      
      Eingabe.TastenbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                         Eingabe.Tastenbelegung);
      
      Close (File => TastenbelegungSpeichern);
      
   end TastenbelegungSchreiben;

end SchreibenTastatur;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with EingabeSFML;

package body SchreibenTastatur is

   procedure TastenbelegungSchreiben
   is begin
      
      case
        Exists (Name => "Tastenbelegung")
      is
         when True =>
            Open (File => TastenbelegungSpeichern,
                  Mode => Out_File,
                  Name => "Tastenbelegung");
            
         when False =>
            Create (File => TastenbelegungSpeichern,
                    Mode => Out_File,
                    Name => "Tastenbelegung");
      end case;
      
      EingabeSFML.TastenbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                             EingabeSFML.Tastenbelegung);
      
      Close (File => TastenbelegungSpeichern);
      
   end TastenbelegungSchreiben;

end SchreibenTastatur;

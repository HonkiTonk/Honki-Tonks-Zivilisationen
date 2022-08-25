pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with TastenbelegungVariablen;

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
      
      TastenbelegungVariablen.TastenbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                                         TastenbelegungVariablen.Tastenbelegung);
      
      Close (File => TastenbelegungSpeichern);
      
   end TastenbelegungSchreiben;

end SchreibenTastatur;

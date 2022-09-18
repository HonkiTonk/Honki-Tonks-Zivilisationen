pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with TastenbelegungVariablen;
with VerzeichnisKonstanten;

package body SchreibenTastaturLogik is

   procedure TastenbelegungSchreiben
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Tastenbelegung)
      is
         when True =>
            Open (File => TastenbelegungSpeichern,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.Tastenbelegung);
            
         when False =>
            Create (File => TastenbelegungSpeichern,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.Tastenbelegung);
      end case;
      
      TastenbelegungVariablen.TastenbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                                         TastenbelegungVariablen.Tastenbelegung);
      
      Close (File => TastenbelegungSpeichern);
      
   end TastenbelegungSchreiben;

end SchreibenTastaturLogik;

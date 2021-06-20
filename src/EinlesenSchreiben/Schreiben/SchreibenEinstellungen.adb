pragma SPARK_Mode (On);

with Ada.Directories;
use Ada.Directories;

with GlobaleVariablen, GlobaleRecords;

package body SchreibenEinstellungen is

   procedure SchreibenEinstellungen
   is begin
      
      case
        Exists (Name => "Einstellungen/Einstellungen")
      is
         when True =>
            Open (File => DateiEinstellungenSchreiben,
                  Mode => Out_File,
                  Name => "Einstellungen/Einstellungen");

         when False =>
            Create (File => DateiEinstellungenSchreiben,
                    Mode => Out_File,
                    Name => "Einstellungen/Einstellungen");
      end case;
         
      GlobaleRecords.NutzerEinstellungenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                                      GlobaleVariablen.NutzerEinstellungen);
      
      Close (File => DateiEinstellungenSchreiben);
      
   end SchreibenEinstellungen;

end SchreibenEinstellungen;

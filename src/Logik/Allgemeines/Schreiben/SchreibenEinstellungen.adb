pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with OptionenVariablen;
with SystemRecords;

with GrafikEinstellungenSFML;

package body SchreibenEinstellungen is

   procedure SchreibenEinstellungen
   is begin
      
      case
        Exists (Name => "Einstellungen")
      is
         when True =>
            Open (File => DateiEinstellungenSchreiben,
                  Mode => Out_File,
                  Name => "Einstellungen");

         when False =>
            Create (File => DateiEinstellungenSchreiben,
                    Mode => Out_File,
                    Name => "Einstellungen");
      end case;
         
      SystemRecords.NutzerEinstellungenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                                     OptionenVariablen.NutzerEinstellungen);
      
      SystemRecords.FensterRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                         GrafikEinstellungenSFML.FensterEinstellungen);
      SystemRecords.SchriftgrößenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                                 GrafikEinstellungenSFML.Schriftgrößen);
      SystemRecords.SchriftfarbenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                               GrafikEinstellungenSFML.Schriftfarben);
      GrafikEinstellungenSFML.RassenFarbenArray'Write (Stream (File => DateiEinstellungenSchreiben),
                                                       GrafikEinstellungenSFML.RassenFarben);
      GrafikEinstellungenSFML.RassenFarbenArray'Write (Stream (File => DateiEinstellungenSchreiben),
                                                       GrafikEinstellungenSFML.RassenFarbenRahmen);
      
      Close (File => DateiEinstellungenSchreiben);
      
   end SchreibenEinstellungen;

end SchreibenEinstellungen;

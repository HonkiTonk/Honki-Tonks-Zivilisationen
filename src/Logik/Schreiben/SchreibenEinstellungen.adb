pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with OptionenVariablen;
with SystemRecords;
with TextKonstanten;

with GrafikEinstellungenSFML;
with TexteinstellungenSFML;
with RasseneinstellungenSFML;

package body SchreibenEinstellungen is

   procedure SchreibenEinstellungen
   is begin
      
      case
        Exists (Name => TextKonstanten.Einstellungen)
      is
         when True =>
            Open (File => DateiEinstellungenSchreiben,
                  Mode => Out_File,
                  Name => TextKonstanten.Einstellungen);

         when False =>
            Create (File => DateiEinstellungenSchreiben,
                    Mode => Out_File,
                    Name => TextKonstanten.Einstellungen);
      end case;
         
      SystemRecords.NutzerEinstellungenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                                     OptionenVariablen.NutzerEinstellungen);
      
      SystemRecords.FensterRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                         GrafikEinstellungenSFML.FensterEinstellungen);
      SystemRecords.SchriftgrößenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                                 TexteinstellungenSFML.Schriftgrößen);
      SystemRecords.SchriftfarbenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                               TexteinstellungenSFML.Schriftfarben);
      RasseneinstellungenSFML.RassenFarbenArray'Write (Stream (File => DateiEinstellungenSchreiben),
                                                       RasseneinstellungenSFML.RassenFarben);
      RasseneinstellungenSFML.RassenFarbenArray'Write (Stream (File => DateiEinstellungenSchreiben),
                                                       RasseneinstellungenSFML.RassenFarbenRahmen);
      
      Close (File => DateiEinstellungenSchreiben);
      
   end SchreibenEinstellungen;

end SchreibenEinstellungen;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with SystemRecords;
with OptionenVariablen;

with GrafikEinstellungenSFML;
with TexteinstellungenSFML;
with RasseneinstellungenSFML;

package body EinlesenEinstellungen is

   procedure EinlesenEinstellungen
   is begin
      
      case
        Exists (Name => "Einstellungen")
      is
         when True =>
            Open (File => DateiEinstellungenEinlesen,
                  Mode => In_File,
                  Name => "Einstellungen");

         when False =>
            GrafikEinstellungenSFML.StandardGrafikEinstellungenLaden;
            return;
      end case;
         
      SystemRecords.NutzerEinstellungenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                                    OptionenVariablen.NutzerEinstellungen);
      
      SystemRecords.FensterRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                        GrafikEinstellungenSFML.FensterEinstellungen);
      SystemRecords.SchriftgrößenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                                TexteinstellungenSFML.Schriftgrößen);
      SystemRecords.SchriftfarbenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                              TexteinstellungenSFML.Schriftfarben);
      RasseneinstellungenSFML.RassenFarbenArray'Read (Stream (File => DateiEinstellungenEinlesen),
                                                      RasseneinstellungenSFML.RassenFarben);
      RasseneinstellungenSFML.RassenFarbenArray'Read (Stream (File => DateiEinstellungenEinlesen),
                                                      RasseneinstellungenSFML.RassenFarbenRahmen);

      Close (File => DateiEinstellungenEinlesen);
      
   end EinlesenEinstellungen;

end EinlesenEinstellungen;

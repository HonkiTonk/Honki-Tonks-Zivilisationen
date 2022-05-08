pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with SystemRecords;
with OptionenVariablen;

with SchreibenEinstellungen;
with GrafikEinstellungenSFML;

package body EinlesenEinstellungen is

   procedure EinlesenEinstellungen
   is begin
      
      case
        Exists (Name => "Einstellungen/Einstellungen")
      is
         when True =>
            Open (File => DateiEinstellungenEinlesen,
                  Mode => In_File,
                  Name => "Einstellungen/Einstellungen");

         when False =>
            GrafikEinstellungenSFML.StandardGrafikEinstellungenLaden;
            -- Muss das schreiben hier sein? Könnte auch weggelassen werden, bis der Nutzer eigene Einstellungen vornimmt.
            SchreibenEinstellungen.SchreibenEinstellungen;
            return;
      end case;
         
      SystemRecords.NutzerEinstellungenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                                    OptionenVariablen.NutzerEinstellungen);
      
      SystemRecords.FensterRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                        GrafikEinstellungenSFML.FensterEinstellungen);
      SystemRecords.SchriftgrößenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                                GrafikEinstellungenSFML.Schriftgrößen);
      SystemRecords.SchriftfarbenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                              GrafikEinstellungenSFML.Schriftfarben);
      GrafikEinstellungenSFML.RassenFarbenArray'Read (Stream (File => DateiEinstellungenEinlesen),
                                                      GrafikEinstellungenSFML.RassenFarben);
      GrafikEinstellungenSFML.RassenFarbenArray'Read (Stream (File => DateiEinstellungenEinlesen),
                                                      GrafikEinstellungenSFML.RassenFarbenRahmen);

      Close (File => DateiEinstellungenEinlesen);
      
   end EinlesenEinstellungen;

end EinlesenEinstellungen;

pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;

with GlobaleVariablen;
with SystemRecords;

with SchreibenEinstellungen;
with EinstellungenSFML;

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
            EinstellungenSFML.StandardGrafikEinstellungenLaden;
            -- Muss das schreiben hier sein? Könnte auch weggelassen werden, bis der Nutzer eigene Einstellungen vornimmt.
            SchreibenEinstellungen.SchreibenEinstellungen;
            return;
      end case;
         
      SystemRecords.NutzerEinstellungenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                                    GlobaleVariablen.NutzerEinstellungen);
      
      SystemRecords.FensterRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                        EinstellungenSFML.FensterEinstellungen);
      SystemRecords.SchriftfarbenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                              EinstellungenSFML.Schriftfarben);
      EinstellungenSFML.RassenFarbenArray'Read (Stream (File => DateiEinstellungenEinlesen),
                                                EinstellungenSFML.RassenFarben);

      Close (File => DateiEinstellungenEinlesen);
      
   end EinlesenEinstellungen;

end EinlesenEinstellungen;

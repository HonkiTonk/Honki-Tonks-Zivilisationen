pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;

with GlobaleVariablen;
with SystemRecords;

with SchreibenEinstellungen;
with GrafikEinstellungen;

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
            GrafikEinstellungen.StandardGrafikEinstellungenLaden;
            SchreibenEinstellungen.SchreibenEinstellungen;
            return;
      end case;
         
      SystemRecords.NutzerEinstellungenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                                    GlobaleVariablen.NutzerEinstellungen);
      
      SystemRecords.FensterRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                        GrafikEinstellungen.FensterEinstellungen);

      Close (File => DateiEinstellungenEinlesen);
      
   end EinlesenEinstellungen;

end EinlesenEinstellungen;

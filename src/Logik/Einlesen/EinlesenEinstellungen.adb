pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with SystemRecords;
with OptionenVariablen;
with TextKonstanten;

with EinstellungenGrafik;
with TexteinstellungenGrafik;
with RasseneinstellungenGrafik;

package body EinlesenEinstellungen is

   procedure EinlesenEinstellungen
   is begin
      
      case
        Exists (Name => TextKonstanten.Einstellungen)
      is
         when True =>
            Open (File => DateiEinstellungenEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.Einstellungen);

         when False =>
            EinstellungenGrafik.StandardeinstellungenLaden;
            return;
      end case;
         
      SystemRecords.NutzerEinstellungenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                                    OptionenVariablen.NutzerEinstellungen);
      
      SystemRecords.FensterRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                        EinstellungenGrafik.FensterEinstellungen);
      SystemRecords.SchriftgrößenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                                TexteinstellungenGrafik.Schriftgrößen);
      SystemRecords.SchriftfarbenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                              TexteinstellungenGrafik.Schriftfarben);
      RasseneinstellungenGrafik.RassenFarbenArray'Read (Stream (File => DateiEinstellungenEinlesen),
                                                      RasseneinstellungenGrafik.Rassenfarben);
      RasseneinstellungenGrafik.RassenFarbenArray'Read (Stream (File => DateiEinstellungenEinlesen),
                                                      RasseneinstellungenGrafik.RassenfarbenRahmen);

      Close (File => DateiEinstellungenEinlesen);
      
   end EinlesenEinstellungen;

end EinlesenEinstellungen;

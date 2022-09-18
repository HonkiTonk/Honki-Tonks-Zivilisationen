pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with SystemRecords;
with OptionenVariablen;
with VerzeichnisKonstanten;
with GrafikRecords;

with EinstellungenGrafik;
with TexteinstellungenGrafik;
with RasseneinstellungenGrafik;

package body EinlesenEinstellungenLogik is

   procedure EinlesenEinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Einstellungen)
      is
         when True =>
            Open (File => DateiEinstellungenEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Einstellungen);

         when False =>
            EinstellungenGrafik.StandardeinstellungenLaden;
            return;
      end case;
         
      SystemRecords.NutzerEinstellungenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                                    OptionenVariablen.NutzerEinstellungen);
      
      GrafikRecords.FensterRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                        EinstellungenGrafik.FensterEinstellungen);
      GrafikRecords.GrafikeinstellungenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                                    EinstellungenGrafik.Grafikeinstellungen);
      
      GrafikRecords.SchriftgrößenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                                TexteinstellungenGrafik.Schriftgrößen);
      GrafikRecords.SchriftfarbenRecord'Read (Stream (File => DateiEinstellungenEinlesen),
                                              TexteinstellungenGrafik.Schriftfarben);
      
      RasseneinstellungenGrafik.RassenFarbenArray'Read (Stream (File => DateiEinstellungenEinlesen),
                                                        RasseneinstellungenGrafik.Rassenfarben);
      RasseneinstellungenGrafik.RassenFarbenArray'Read (Stream (File => DateiEinstellungenEinlesen),
                                                        RasseneinstellungenGrafik.RassenfarbenRahmen);

      Close (File => DateiEinstellungenEinlesen);
      
   end EinlesenEinstellungen;

end EinlesenEinstellungenLogik;

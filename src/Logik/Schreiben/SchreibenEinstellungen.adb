pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with OptionenVariablen;
with SystemRecords;
with VerzeichnisKonstanten;
with GrafikRecords;

with EinstellungenGrafik;
with TexteinstellungenGrafik;
with RasseneinstellungenGrafik;

package body SchreibenEinstellungen is

   procedure SchreibenEinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Einstellungen)
      is
         when True =>
            Open (File => DateiEinstellungenSchreiben,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.Einstellungen);

         when False =>
            Create (File => DateiEinstellungenSchreiben,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.Einstellungen);
      end case;
         
      SystemRecords.NutzerEinstellungenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                                     OptionenVariablen.NutzerEinstellungen);
      
      GrafikRecords.FensterRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                         EinstellungenGrafik.FensterEinstellungen);
      GrafikRecords.GrafikeinstellungenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                                     EinstellungenGrafik.Grafikeinstellungen);
      
      GrafikRecords.SchriftgrößenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                                 TexteinstellungenGrafik.Schriftgrößen);
      GrafikRecords.SchriftfarbenRecord'Write (Stream (File => DateiEinstellungenSchreiben),
                                               TexteinstellungenGrafik.Schriftfarben);
      
      RasseneinstellungenGrafik.RassenFarbenArray'Write (Stream (File => DateiEinstellungenSchreiben),
                                                         RasseneinstellungenGrafik.Rassenfarben);
      RasseneinstellungenGrafik.RassenFarbenArray'Write (Stream (File => DateiEinstellungenSchreiben),
                                                         RasseneinstellungenGrafik.RassenfarbenRahmen);
      
      Close (File => DateiEinstellungenSchreiben);
      
   end SchreibenEinstellungen;

end SchreibenEinstellungen;

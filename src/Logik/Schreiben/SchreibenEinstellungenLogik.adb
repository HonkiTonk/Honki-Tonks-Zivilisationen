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

package body SchreibenEinstellungenLogik is
   
   procedure Nutzereinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Nutzereinstellungen)
      is
         when True =>
            Open (File => DateiNutzereinstellungen,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.Nutzereinstellungen);

         when False =>
            Create (File => DateiNutzereinstellungen,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.Nutzereinstellungen);
      end case;
      
      SystemRecords.NutzerEinstellungenRecord'Write (Stream (File => DateiNutzereinstellungen),
                                                     OptionenVariablen.NutzerEinstellungen);
      
      Close (File => DateiNutzereinstellungen);
      
   end Nutzereinstellungen;
   
   
   
   procedure Grafikeinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafikeinstellungen)
      is
         when True =>
            Open (File => DateiGrafikeinstellungen,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.Grafikeinstellungen);

         when False =>
            Create (File => DateiGrafikeinstellungen,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.Grafikeinstellungen);
      end case;
            
      GrafikRecords.FensterRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                         EinstellungenGrafik.FensterEinstellungen);
      GrafikRecords.GrafikeinstellungenRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                                     EinstellungenGrafik.Grafikeinstellungen);
      
      GrafikRecords.SchriftgrößenRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                                 TexteinstellungenGrafik.Schriftgrößen);
      GrafikRecords.SchriftfarbenRecord'Write (Stream (File => DateiGrafikeinstellungen),
                                               TexteinstellungenGrafik.Schriftfarben);
      
      RasseneinstellungenGrafik.RassenFarbenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                         RasseneinstellungenGrafik.Rassenfarben);
      RasseneinstellungenGrafik.RassenFarbenArray'Write (Stream (File => DateiGrafikeinstellungen),
                                                         RasseneinstellungenGrafik.RassenfarbenRahmen);
      
      Close (File => DateiGrafikeinstellungen);
      
   end Grafikeinstellungen;
   
   
   
   procedure Soundeinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Soundeinstelllungen)
      is
         when True =>
            Open (File => DateiSoundeinstellungen,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.Soundeinstelllungen);

         when False =>
            Create (File => DateiSoundeinstellungen,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.Soundeinstelllungen);
      end case;
      
      
      
      Close (File => DateiSoundeinstellungen);
            
   end Soundeinstellungen;

end SchreibenEinstellungenLogik;

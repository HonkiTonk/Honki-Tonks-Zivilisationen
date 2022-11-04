pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with SystemRecords;
with OptionenVariablen;
with VerzeichnisKonstanten;
with GrafikRecords;

with EinstellungenGrafik;
with TexteinstellungenGrafik;
with RasseneinstellungenGrafik;
with EinstellungenMusik;
with EinstellungenSound;

package body EinlesenEinstellungenLogik is

   procedure EinlesenEinstellungen
   is begin
      
      Nutzereinstellungen;
      Grafikeinstellungen;
      Soundeinstelllungen;
      
   end EinlesenEinstellungen;
   
   
   
   procedure Nutzereinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Nutzereinstellungen)
      is
         when True =>
            Open (File => DateiNutzereinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Nutzereinstellungen);
         
            SystemRecords.NutzerEinstellungenRecord'Read (Stream (File => DateiNutzereinstellungen),
                                                          OptionenVariablen.NutzerEinstellungen);

            Close (File => DateiNutzereinstellungen);

         when False =>
            null;
      end case;
      
   end Nutzereinstellungen;
   
   
   
   procedure Grafikeinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafikeinstellungen)
      is
         when True =>
            Open (File => DateiGrafikeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafikeinstellungen);
            
            GrafikRecords.FensterRecord'Read (Stream (File => DateiGrafikeinstellungen),
                                              EinstellungenGrafik.FensterEinstellungen);
            GrafikRecords.GrafikeinstellungenRecord'Read (Stream (File => DateiGrafikeinstellungen),
                                                          EinstellungenGrafik.Grafikeinstellungen);
      
            GrafikRecords.SchriftgrößenRecord'Read (Stream (File => DateiGrafikeinstellungen),
                                                      TexteinstellungenGrafik.Schriftgrößen);
            GrafikRecords.SchriftfarbenRecord'Read (Stream (File => DateiGrafikeinstellungen),
                                                    TexteinstellungenGrafik.Schriftfarben);
      
            RasseneinstellungenGrafik.RassenFarbenArray'Read (Stream (File => DateiGrafikeinstellungen),
                                                              RasseneinstellungenGrafik.Rassenfarben);
            RasseneinstellungenGrafik.RassenFarbenArray'Read (Stream (File => DateiGrafikeinstellungen),
                                                              RasseneinstellungenGrafik.RassenfarbenRahmen);
      
            Close (File => DateiGrafikeinstellungen);

         when False =>
            EinstellungenGrafik.StandardeinstellungenLaden;
      end case;
      
   end Grafikeinstellungen;
   
   
   
   procedure Soundeinstelllungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Soundeinstelllungen)
      is
         when True =>
            Open (File => DateiSoundeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Soundeinstelllungen);
            
            
      
            Close (File => DateiSoundeinstellungen);

         when False =>
            EinstellungenMusik.StandardeinstellungenLaden;
            EinstellungenSound.StandardeinstellungenLaden;
      end case;
      
   end Soundeinstelllungen;

end EinlesenEinstellungenLogik;

with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;
with OptionenVariablen;

with SchreibeOptionen;

with EinstellungenGrafik;
with EinstellungenMusik;
with EinstellungenSound;
with SchreibeEinstellungenGrafik;

-- Das eventuell nach Bereichen aufteilen? äöü
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
         when False =>
            OptionenVariablen.StandardeinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiNutzereinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Nutzereinstellungen);
            
            PrüfungErfolgreich := NutzereinstellungenDurchgehen (LadenPrüfenExtern => False);

            Close (File => DateiNutzereinstellungen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when False =>
            OptionenVariablen.StandardeinstellungenLaden;
            
         when True =>
            Open (File => DateiNutzereinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Nutzereinstellungen);
            
            Nullwert := NutzereinstellungenDurchgehen (LadenPrüfenExtern => True);

            Close (File => DateiNutzereinstellungen);
      end case;
      
   end Nutzereinstellungen;
   
   
   
   function NutzereinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
            
      SystemRecords.NutzerEinstellungenRecord'Read (Stream (File => DateiNutzereinstellungen),
                                                    ZwischenspeicherNutzereinstellungen);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            SchreibeOptionen.GanzerEintrag (EintragExtern => ZwischenspeicherNutzereinstellungen);
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
      
   end NutzereinstellungenDurchgehen;
   
   
   
   procedure Grafikeinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafikeinstellungen)
      is
         when False =>
            EinstellungenGrafik.StandardeinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiGrafikeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafikeinstellungen);
            
            PrüfungErfolgreich := GrafikeinstellungenDurchgehen (LadenPrüfenExtern => False);
                        
            Close (File => DateiGrafikeinstellungen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DateiGrafikeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafikeinstellungen);
            
            Nullwert := GrafikeinstellungenDurchgehen (LadenPrüfenExtern => True);
                        
            Close (File => DateiGrafikeinstellungen);
            
         when False =>
            EinstellungenGrafik.StandardeinstellungenLaden;
      end case;
      
   end Grafikeinstellungen;
   
   
   
   function GrafikeinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      GrafikRecords.FensterRecord'Read (Stream (File => DateiGrafikeinstellungen),
                                        Fenstereinstellungen);
      GrafikRecords.GrafikeinstellungenRecord'Read (Stream (File => DateiGrafikeinstellungen),
                                                    ZwischenspeicherGrafikeinstellungen);
      
      TexteinstellungenGrafik.SchriftgrößenArray'Read (Stream (File => DateiGrafikeinstellungen),
                                                         Schriftgrößen);
      TexteinstellungenGrafik.SchriftfarbenArray'Read (Stream (File => DateiGrafikeinstellungen),
                                                       Schriftfarben);
            
      SpezieseinstellungenGrafik.SpeziesFarbenArray'Read (Stream (File => DateiGrafikeinstellungen),
                                                          Speziesfarben);
      SpezieseinstellungenGrafik.SpeziesFarbenArray'Read (Stream (File => DateiGrafikeinstellungen),
                                                          Rahmenfarben);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            SchreibeEinstellungenGrafik.Fenstereinstellungen (EintragExtern => Fenstereinstellungen);
            SchreibeEinstellungenGrafik.Grafikeinstellungen (EintragExtern => ZwischenspeicherGrafikeinstellungen);
            
            TexteinstellungenGrafik.SchriftgrößeneintragSchreiben (EintragExtern => Schriftgrößen);
            TexteinstellungenGrafik.SchriftfarbeneintragSchreiben (EintragExtern => Schriftfarben);
            
            SpezieseinstellungenGrafik.FarbenarraySchreiben (FarbenExtern => Speziesfarben);
            SpezieseinstellungenGrafik.RahmenarraySchreiben (FarbenExtern => Rahmenfarben);
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
      
   end GrafikeinstellungenDurchgehen;
   
   
   
   procedure Soundeinstelllungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Soundeinstelllungen)
      is
         when False =>
            EinstellungenMusik.StandardeinstellungenLaden;
            EinstellungenSound.StandardeinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiSoundeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Soundeinstelllungen);
            
            PrüfungErfolgreich := SoundeinstellungenDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DateiSoundeinstellungen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DateiSoundeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Soundeinstelllungen);
            
            Nullwert := SoundeinstellungenDurchgehen (LadenPrüfenExtern => True);
      
            Close (File => DateiSoundeinstellungen);
            
         when False =>
            EinstellungenMusik.StandardeinstellungenLaden;
            EinstellungenSound.StandardeinstellungenLaden;
      end case;
      
   end Soundeinstelllungen;
   
   
   
   function SoundeinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
         
   end SoundeinstellungenDurchgehen;

end EinlesenEinstellungenLogik;

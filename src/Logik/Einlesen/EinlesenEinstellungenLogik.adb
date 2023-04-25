with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;
with OptionenVariablen;

with SchreibeOptionen;
with SchreibeEinstellungenSound;
with SchreibeEinstellungenMusik;
with SchreibeEinstellungenGrafik;

with EinstellungenGrafik;
with EinstellungenMusik;
with EinstellungenSound;

package body EinlesenEinstellungenLogik is

   procedure EinlesenEinstellungen
   is begin
      
      Nutzereinstellungen;
      Grafikeinstellungen;
      Toneinstelllungen;
      
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
                  Name => VerzeichnisKonstanten.Nutzereinstellungen,
                  Form => "WCEM=8");
            
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
                  Name => VerzeichnisKonstanten.Nutzereinstellungen,
                  Form => "WCEM=8");
            
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
                  Name => VerzeichnisKonstanten.Grafikeinstellungen,
                  Form => "WCEM=8");
            
            PrüfungErfolgreich := GrafikeinstellungenDurchgehen (LadenPrüfenExtern => False);
                        
            Close (File => DateiGrafikeinstellungen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DateiGrafikeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafikeinstellungen,
                  Form => "WCEM=8");
            
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
   
   
   
   procedure Toneinstelllungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Toneinstellungen)
      is
         when False =>
            EinstellungenMusik.StandardeinstellungenLaden;
            EinstellungenSound.StandardeinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiSoundeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Toneinstellungen,
                  Form => "WCEM=8");
            
            PrüfungErfolgreich := ToneinstellungenDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DateiSoundeinstellungen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DateiSoundeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Toneinstellungen,
                  Form => "WCEM=8");
            
            Nullwert := ToneinstellungenDurchgehen (LadenPrüfenExtern => True);
      
            Close (File => DateiSoundeinstellungen);
            
         when False =>
            EinstellungenMusik.StandardeinstellungenLaden;
            EinstellungenSound.StandardeinstellungenLaden;
      end case;
      
   end Toneinstelllungen;
   
   
   
   function ToneinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      TonRecords.SoundeinstellungenRecord'Read (Stream (File => DateiSoundeinstellungen),
                                                Soundeinstellungen);
      
      TonRecords.MusikeinstellungenRecord'Read (Stream (File => DateiSoundeinstellungen),
                                                Musikeinstellungen);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            SchreibeEinstellungenSound.GanzerEintrag (EintragExtern => Soundeinstellungen);
            SchreibeEinstellungenMusik.GanzerEintrag (EintrageExtern => Musikeinstellungen);
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
         
   end ToneinstellungenDurchgehen;

end EinlesenEinstellungenLogik;

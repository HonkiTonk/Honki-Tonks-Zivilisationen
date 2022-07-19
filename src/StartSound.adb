pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;
with OptionenVariablen;
with GrafikDatentypen;

with SoundSFML;
with SoundTerminal;
with Fehler;
with NachSoundtask;
with VonLogiktaskAnAlle;

package body StartSound is

   procedure StartSound
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      EinlesenAbwartenSchleife:
      while VonLogiktaskAnAlle.EinlesenAbgeschlossen = False loop
         
         delay ZeitKonstanten.WartezeitSound;
         
      end loop EinlesenAbwartenSchleife;
      
      case
        NachSoundtask.AktuellerSound
      is
         when TonDatentypen.Sound_SFML_Enum =>
            SoundSFML.SoundSFML;
            
         when TonDatentypen.Sound_Terminal_Enum =>
            SoundTerminal.SoundTerminal;
            
         when others =>
            Fehler.SoundFehler (FehlermeldungExtern => "StartSound.StartSound - Ungültige Soundwiedergabeart.");
      end case;
      
   end StartSound;

end StartSound;

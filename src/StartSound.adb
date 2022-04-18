pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;
with OptionenVariablen;
with GrafikDatentypen;

with SoundSFML;
with InteraktionLogiktask;
with SoundKonsole;
with Fehler;
with InteraktionSoundtask;

package body StartSound is

   procedure StartSound
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      EinlesenAbwartenSchleife:
      while InteraktionLogiktask.EinlesenAbgeschlossen = False loop
         
         delay ZeitKonstanten.WartezeitSound;
         
      end loop EinlesenAbwartenSchleife;
      
      case
        InteraktionSoundtask.AktuellenSoundAbfragen
      is
         when TonDatentypen.Sound_SFML_Enum =>
            SoundSFML.SoundSFML;
            
         when TonDatentypen.Sound_Konsole_Enum =>
            SoundKonsole.SoundKonsole;
            
         when others =>
            Fehler.SoundFehler (FehlermeldungExtern => "StartSound.StartSound - Ungültige Soundwiedergabeart.");
      end case;
      
   end StartSound;

end StartSound;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with SystemKonstanten;
with GlobaleVariablen;

with SoundSFML;
with InteraktionLogiktask;
with SoundKonsole;
with Fehler;
with InteraktionSoundtask;

package body StartSound is

   procedure StartSound
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            return;
            
         when others =>
            null;
      end case;
      
      EinlesenAbwartenSchleife:
      while InteraktionLogiktask.EinlesenAbgeschlossen = False loop
         
         delay SystemKonstanten.WartezeitSound;
         
      end loop EinlesenAbwartenSchleife;
      
      case
        InteraktionSoundtask.AktuellenSoundAbfragen
      is
         when SystemDatentypen.Sound_SFML =>
            SoundSFML.SoundSFML;
            
         when SystemDatentypen.Sound_Konsole =>
            SoundKonsole.SoundKonsole;
            
         when others =>
            Fehler.SoundFehler (FehlermeldungExtern => "StartSound.StartSound - Ungültige Soundwiedergabeart.");
      end case;
      
   end StartSound;

end StartSound;

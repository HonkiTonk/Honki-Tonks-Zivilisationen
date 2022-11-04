pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;

with NachSoundtask;
with StartEndeSound;
with LogiktaskAnAlle;

package body Sound is

   procedure Sound
   is begin
      
      EinlesenAbwartenSchleife:
      while LogiktaskAnAlle.EinlesenAbgeschlossen = False loop
         
         delay ZeitKonstanten.WartezeitSound;
         
      end loop EinlesenAbwartenSchleife;
      
      -- Sound wird direkt parallel aufgerufen. Steht auch im SFML Tutorial und der Beschreibung der ASFML.
      StartEndeSound.Abspielen;
      
      SoundSchleife:
      loop
         
         case
           NachSoundtask.AktuellerSound
         is
            when TonDatentypen.Sound_Pause_Enum =>
               delay ZeitKonstanten.WartezeitSound;
               
            when TonDatentypen.Sound_Ende_Enum =>
               exit SoundSchleife;
         end case;
         
      end loop SoundSchleife;
      
      StartEndeSound.Stoppen;
      StartEndeSound.Entfernen;
      
   end Sound;

end Sound;

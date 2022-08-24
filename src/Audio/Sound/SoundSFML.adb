pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;

with NachSoundtask;
with SoundStartEndeSFML;
with VonLogiktaskAnAlle;

package body SoundSFML is

   procedure SoundSFML
   is begin
      
      EinlesenAbwartenSchleife:
      while VonLogiktaskAnAlle.EinlesenAbgeschlossen = False loop
         
         delay ZeitKonstanten.WartezeitSound;
         
      end loop EinlesenAbwartenSchleife;
      
      -- Sound wird direkt parallel aufgerufen. Steht auch im SFML Tutorial und der Beschreibung der ASFML.
      SoundStartEndeSFML.SoundAbspielen;
      
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
      
      SoundStartEndeSFML.SoundStoppen;
      SoundStartEndeSFML.SoundEntfernen;
      
   end SoundSFML;

end SoundSFML;

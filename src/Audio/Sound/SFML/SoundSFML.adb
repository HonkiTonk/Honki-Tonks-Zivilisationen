pragma SPARK_Mode (On);

with Sf.Audio; use Sf.Audio;
with Sf.Audio.SoundBuffer;

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;

with InteraktionSoundtask;
with Fehler;
with EingeleseneSounds;

package body SoundSFML is

   procedure SoundSFML
   is begin
      
      -- Sound wird direkt parallel aufgerufen. Steht auch im SFML Tutorial und der Beschreibung der ASFML.
      if
        EingeleseneSounds.Sound (SystemKonstanten.LeerRasse, 1) = null
      then
         null;
         
      else
         Sf.Audio.Sound.setBuffer (sound  => SoundTest,
                                   buffer => EingeleseneSounds.Sound (SystemKonstanten.LeerRasse, 1));
         Sf.Audio.Sound.play (sound => SoundTest);
      end if;
      
      SoundSchleife:
      loop
         
         case
           InteraktionSoundtask.AktuellenSoundAbfragen
         is
            when SystemDatentypen.Sound_Konsole =>
               Fehler.SoundStopp (FehlermeldungExtern => "SoundSFML.SoundSFML - Konsole wird bei SFML aufgerufen.");
               
            when SystemDatentypen.Sound_SFML =>
               delay SystemKonstanten.WartezeitSound;
               
            when SystemDatentypen.Sound_Ende =>
               exit SoundSchleife;
         end case;
         
      end loop SoundSchleife;
      
      if
        EingeleseneSounds.Sound (SystemKonstanten.LeerRasse, 1) = null
      then
         null;
         
      else
         -- Vor dem stoppen noch prüfen ob überhaupt Sound läuft?
         Sf.Audio.Sound.stop (sound => SoundTest);
         -- Beide destroys sind nötig sonst gibt es die Fehlermeldung "AL lib: (EE) alc_cleanup: 1 device not closed" beim Beenden des Programms.
         Sf.Audio.SoundBuffer.destroy (soundBuffer => EingeleseneSounds.Sound (SystemKonstanten.LeerRasse, 1));
         Sf.Audio.Sound.destroy (sound => SoundTest);
      end if;
      
   end SoundSFML;

end SoundSFML;

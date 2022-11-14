with Sf.Audio.SoundBuffer;

with EingeleseneSounds;

package body StartEndeSound is

   procedure Abspielen
   is
      use type Sf.Audio.sfSoundBuffer_Ptr;
   begin
      
      -- Sound wird direkt parallel aufgerufen. Steht auch im SFML Tutorial und der Beschreibung der ASFML.
      if
        EingeleseneSounds.Sound (1) = null
      then
         null;
         
      else
         Sf.Audio.Sound.setBuffer (sound  => SoundTest,
                                   buffer => EingeleseneSounds.Sound (1));
         Sf.Audio.Sound.play (sound => SoundTest);
      end if;
      
   end Abspielen;
   
   
   
   procedure Stoppen
   is
      use type Sf.Audio.sfSoundBuffer_Ptr;
   begin
      
      -- Anders als bei Musik scheint hier die Prüfung nicht notwendig zu sein?
      if
        EingeleseneSounds.Sound (1) = null
      then
         null;
         
      else
         Sf.Audio.Sound.stop (sound => SoundTest);
      end if;
      
   end Stoppen;
   
   
   
   procedure Entfernen
   is begin
      
      -- Beide destroys sind nötig sonst gibt es die Fehlermeldung "AL lib: (EE) alc_cleanup: 1 device not closed" beim Beenden des Programms.
      Sf.Audio.SoundBuffer.destroy (soundBuffer => EingeleseneSounds.Sound (1));
      Sf.Audio.Sound.destroy (sound => SoundTest);
      
   end Entfernen;

end StartEndeSound;

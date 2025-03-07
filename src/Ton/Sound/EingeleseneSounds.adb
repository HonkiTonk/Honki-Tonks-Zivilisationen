package body EingeleseneSounds is

   procedure SoundsFestlegen
   is
      use type Sf.Audio.sfSoundBuffer_Ptr;
      use type Sf.Audio.sfSound_Ptr;
   begin
      
      SoundSchleife:
      for SoundSchleifenwert in SoundaccesseArray'Range loop
         
         if
           Sound (SoundSchleifenwert) = null
         then
            null;
         
         elsif
           Soundaccesse (SoundSchleifenwert) = null
         then
            null;
            
         else
            -- destroy funktioniert hier so nicht, unwichtig? Beser noch mal nachprüfen. äöü
            -- Sf.Audio.Sound.destroy (sound => Soundaccesse (SoundSchleifenwert));
            Sf.Audio.Sound.setBuffer (sound  => Soundaccesse (SoundSchleifenwert),
                                      buffer => Sound (SoundSchleifenwert));
         end if;
         
      end loop SoundSchleife;
      
   end SoundsFestlegen;

end EingeleseneSounds;

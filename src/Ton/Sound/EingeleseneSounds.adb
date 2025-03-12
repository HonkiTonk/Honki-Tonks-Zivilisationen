with Sf.Audio.Sound;

package body EingeleseneSounds is

   procedure SoundsFestlegen
   is
      use type Sf.Audio.sfSoundBuffer_Ptr;
   begin
      
      SoundSchleife:
      for SoundSchleifenwert in SoundAccesseArray'Range loop
         
         if
           SoundbufferAccesse (SoundSchleifenwert) = null
         then
            null;
            
         else
            Sf.Audio.Sound.destroy (sound => SoundAccesse (SoundSchleifenwert));
            SoundAccesse (SoundSchleifenwert) := Sf.Audio.Sound.create;
            Sf.Audio.Sound.setBuffer (sound  => SoundAccesse (SoundSchleifenwert),
                                      buffer => SoundbufferAccesse (SoundSchleifenwert));
         end if;
         
      end loop SoundSchleife;
      
   end SoundsFestlegen;

end EingeleseneSounds;

with Sf.Audio.Sound;

with LeseEinstellungenTon;

with EingeleseneSounds;

package body StarteinstellungenSound is

   procedure Lautstärke
   is
      use type Sf.Audio.sfSound_Ptr;
   begin
      
      SoundSchleife:
      for SoundSchleifenwert in EingeleseneSounds.SoundaccesseArray'Range loop
         
         if
           EingeleseneSounds.Soundaccesse (SoundSchleifenwert) = null
         then
            null;
            
         else
            Sf.Audio.Sound.setVolume (sound  => EingeleseneSounds.Soundaccesse (SoundSchleifenwert),
                                      volume => LeseEinstellungenTon.Soundlautstärke);
         end if;
         
      end loop SoundSchleife;
      
   end Lautstärke;

end StarteinstellungenSound;

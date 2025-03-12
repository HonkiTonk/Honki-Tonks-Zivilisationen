with Sf.Audio.Sound;

with LeseEinstellungenTon;

with EingeleseneSounds;

package body EinstellungenSound is

   procedure Lautstärke
   is
      use type Sf.Audio.sfSound_Ptr;
   begin
      
      Soundlautstärke := LeseEinstellungenTon.Soundlautstärke;
      
      SoundSchleife:
      for SoundSchleifenwert in EingeleseneSounds.SoundAccesseArray'Range loop
         
         if
           EingeleseneSounds.SoundAccesse (SoundSchleifenwert) = null
         then
            null;
            
         else
            Sf.Audio.Sound.setVolume (sound  => EingeleseneSounds.SoundAccesse (SoundSchleifenwert),
                                      volume => Soundlautstärke);
         end if;
         
      end loop SoundSchleife;
      
   end Lautstärke;

end EinstellungenSound;

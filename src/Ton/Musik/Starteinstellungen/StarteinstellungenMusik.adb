with Sf.Audio.Music;

with LeseEinstellungenTon;

with EingeleseneMusik;

package body StarteinstellungenMusik is

   procedure Lautstärke
   is
      use type Sf.Audio.sfMusic_Ptr;
   begin

      LiedSchleife:
      for LiedSchleifenwert in EingeleseneMusik.MusikArray'Range loop

         if
           EingeleseneMusik.Musik (LiedSchleifenwert) = null
         then
            null;

         else
            Sf.Audio.Music.setVolume (music  => EingeleseneMusik.Musik (LiedSchleifenwert),
                                      volume => LeseEinstellungenTon.Musiklautstärke);
         end if;

      end loop LiedSchleife;

   end Lautstärke;

end StarteinstellungenMusik;

with Sf.Audio.Music;

with LeseEinstellungenMusik;

with EingeleseneMusik;

package body StarteinstellungenMusik is

   procedure Lautstärke
   is
      use type Sf.Audio.sfMusic_Ptr;
   begin

      SpeziesSchleife:
      for SpeziesSchleifenwert in EingeleseneMusik.MusikArray'Range (1) loop
         LiedSchleife:
         for LiedSchleifenwert in EingeleseneMusik.MusikArray'Range (2) loop

            if
              EingeleseneMusik.Musik (SpeziesSchleifenwert, LiedSchleifenwert) = null
            then
               null;

            else
               Sf.Audio.Music.setVolume (music  => EingeleseneMusik.Musik (SpeziesSchleifenwert, LiedSchleifenwert),
                                         volume => LeseEinstellungenMusik.Lautstärke);
            end if;

         end loop LiedSchleife;
      end loop SpeziesSchleife;

   end Lautstärke;

end StarteinstellungenMusik;

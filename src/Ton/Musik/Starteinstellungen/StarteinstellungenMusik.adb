with Sf.Audio.Music;

with LeseEinstellungenTon;

with EingeleseneMusik;

package body StarteinstellungenMusik is

   procedure Lautstärke
   is
      use type Sf.Audio.sfMusic_Ptr;
   begin

      IntroSchleife:
      for IntroSchleifenwert in EingeleseneMusik.Intromusik'Range loop

         if
           EingeleseneMusik.Intromusik (IntroSchleifenwert) = null
         then
            null;

         else
            Sf.Audio.Music.setVolume (music  => EingeleseneMusik.Intromusik (IntroSchleifenwert),
                                      volume => LeseEinstellungenTon.Musiklautstärke);
         end if;

      end loop IntroSchleife;



      StandardmusikSchleife:
      for StandardmusikSchleifenwert in EingeleseneMusik.Standardmusik'Range loop

         if
           EingeleseneMusik.Standardmusik (StandardmusikSchleifenwert) = null
         then
            null;

         else
            Sf.Audio.Music.setVolume (music  => EingeleseneMusik.Standardmusik (StandardmusikSchleifenwert),
                                      volume => LeseEinstellungenTon.Musiklautstärke);
         end if;

      end loop StandardmusikSchleife;



      ForschungserfolgSchleife:
      for ForschungserfolgSchleifenwert in EingeleseneMusik.Forschungserfolg'Range loop

         if
           EingeleseneMusik.Forschungserfolg (ForschungserfolgSchleifenwert) = null
         then
            null;

         else
            Sf.Audio.Music.setVolume (music  => EingeleseneMusik.Intromusik (ForschungserfolgSchleifenwert),
                                      volume => LeseEinstellungenTon.Musiklautstärke);
         end if;

      end loop ForschungserfolgSchleife;

   end Lautstärke;

end StarteinstellungenMusik;

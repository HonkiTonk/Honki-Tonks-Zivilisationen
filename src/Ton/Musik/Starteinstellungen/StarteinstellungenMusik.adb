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
      for StandardmusikSchleifenwert in EingeleseneMusik.Spielmusik'Range loop

         if
           EingeleseneMusik.Spielmusik (StandardmusikSchleifenwert) = null
         then
            null;

         else
            Sf.Audio.Music.setVolume (music  => EingeleseneMusik.Spielmusik (StandardmusikSchleifenwert),
                                      volume => LeseEinstellungenTon.Musiklautstärke);
         end if;

      end loop StandardmusikSchleife;



      ForschungserfolgSchleife:
      for ForschungserfolgSchleifenwert in EingeleseneMusik.Forschungsmusik'Range loop

         if
           EingeleseneMusik.Forschungsmusik (ForschungserfolgSchleifenwert) = null
         then
            null;

         else
            Sf.Audio.Music.setVolume (music  => EingeleseneMusik.Intromusik (ForschungserfolgSchleifenwert),
                                      volume => LeseEinstellungenTon.Musiklautstärke);
         end if;

      end loop ForschungserfolgSchleife;

   end Lautstärke;

end StarteinstellungenMusik;

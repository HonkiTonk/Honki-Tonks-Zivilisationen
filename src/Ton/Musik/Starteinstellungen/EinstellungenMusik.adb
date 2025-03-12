with Sf.Audio.Music;

with LeseEinstellungenTon;

with EingeleseneMusik;

package body EinstellungenMusik is

   procedure Lautstärke
   is
      use type Sf.Audio.sfMusic_Ptr;
   begin

      Musiklautstärke := LeseEinstellungenTon.Musiklautstärke;

      IntroSchleife:
      for IntroSchleifenwert in EingeleseneMusik.Intromusik'Range loop

         if
           EingeleseneMusik.Intromusik (IntroSchleifenwert) = null
         then
            null;

         else
            Sf.Audio.Music.setVolume (music  => EingeleseneMusik.Intromusik (IntroSchleifenwert),
                                      volume => Musiklautstärke);
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
                                      volume => Musiklautstärke);
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
                                      volume => Musiklautstärke);
         end if;

      end loop ForschungserfolgSchleife;

   end Lautstärke;

end EinstellungenMusik;

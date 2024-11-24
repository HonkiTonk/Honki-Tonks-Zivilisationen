with Sf.Audio.Music;
with Sf.Audio.SoundStatus;

with TonDatentypen;
with ZeitKonstanten;

with SchreibeLogiktask;
with LeseMusiktask;
with LeseGesamttask;

-- with IntroMusik;
with StartEndeMusik;
with StarteinstellungenMusik;
with EingeleseneMusik;

package body Musik is

   procedure Musik
   is begin
      
      EinlesenAbwartenSchleife:
      while LeseGesamttask.EinstellungenEingelesen = False loop
         
         delay ZeitKonstanten.WartezeitMusik;
         
      end loop EinlesenAbwartenSchleife;
      
      StarteinstellungenMusik.Lautstärke;
      SchreibeLogiktask.WartenMusik (ZustandExtern => False);
         
      -- Musik wird direkt parallel aufgerufen. Steht auch im SFML Tutorial, allerdings unter Sound, und der Beschreibung der ASFML.
      -- Beim Abspielen von Musik einfach immer eine Sekunde delayen bevor geprüft wird ob die Musik noch spielt?
            
      MusikSchleife:
      loop
         
         case
           LeseMusiktask.AktuelleMusik
         is
            when TonDatentypen.Musik_Intro_Enum =>
               case
                 Sf.Audio.Music.getStatus (music => EingeleseneMusik.Intromusik (1))
               is
                  when Sf.Audio.SoundStatus.sfPlaying =>
                     delay ZeitKonstanten.WartezeitMusik;
                     
                  when others =>
                     StartEndeMusik.Abspielen (MusikExtern => EingeleseneMusik.Intromusik (1));
                     -- IntroMusik.Intro;
               end case;
               
            when TonDatentypen.Musik_Pause_Enum =>
               delay ZeitKonstanten.WartezeitMusik;
               
            when TonDatentypen.Musik_Ende_Enum =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
      StartEndeMusik.Stoppen;
      StartEndeMusik.Entfernen;
      
   end Musik;

end Musik;

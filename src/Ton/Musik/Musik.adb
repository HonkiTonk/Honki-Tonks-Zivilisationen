with TonDatentypen;
with ZeitKonstanten;

with NachMusiktask;
with IntroMusik;
with StartEndeMusik;
with LogiktaskAnAlle;
with StarteinstellungenMusik;
with NachLogiktask;

package body Musik is

   procedure Musik
   is begin
      
      EinlesenAbwartenSchleife:
      while LogiktaskAnAlle.EinlesenAbgeschlossen = False loop
         
         delay ZeitKonstanten.WartezeitMusik;
         
      end loop EinlesenAbwartenSchleife;
      
      StarteinstellungenMusik.Lautstärke;
      NachLogiktask.MusikWarten := False;
         
      -- Musik wird direkt parallel aufgerufen. Steht auch im SFML Tutorial, allerdings unter Sound, und der Beschreibung der ASFML.
      -- Beim Abspielen von Musik einfach immer eine Sekunde delayen bevor geprüft wird ob die Musik noch spielt?
      StartEndeMusik.Abspielen;
            
      MusikSchleife:
      loop
         
         case
           NachMusiktask.AktuelleMusik
         is
            when TonDatentypen.Musik_Intro_Enum =>
               IntroMusik.Intro;
               
            when TonDatentypen.Musik_Pause_Enum =>
               delay ZeitKonstanten.WartezeitSound;
               
            when TonDatentypen.Musik_Ende_Enum =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
      StartEndeMusik.Stoppen;
      StartEndeMusik.Entfernen;
      
   end Musik;

end Musik;

pragma SPARK_Mode (On);

with Sf.Audio; use Sf.Audio;
with Sf.Audio.Music;

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;

with InteraktionMusiktask;
with EingeleseneMusik;
with Fehler;
with MusikIntroSFML;

package body MusikSFML is

   procedure MusikSFML
   is begin
         
      -- Musik wird direkt parallel aufgerufen. Steht auch im SFML Tutorial, allerdings unter Sound, und der Beschreibung der ASFML.
      -- Beim Abspielen von Musik einfach immer eine Sekunde delayen bevor geprüft wird ob die Musik noch spielt?
      if
        EingeleseneMusik.Musik (SystemKonstanten.LeerRasse, 1) = null
      then
         null;
         
      else
         Sf.Audio.Music.play (music => EingeleseneMusik.Musik (SystemKonstanten.LeerRasse, 1));
      end if;
      
      MusikSchleife:
      loop
         
         case
           InteraktionMusiktask.AktuelleMusik
         is
            when SystemDatentypen.Musik_Konsole =>
               Fehler.MusikStopp (FehlermeldungExtern => "MusikSFML.Musik - Konsole wird bei SFML aufgerufen.");
               
            when SystemDatentypen.Musik_Intro =>
               MusikIntroSFML.Intro;
               
            when SystemDatentypen.Musik_SFML =>
               delay SystemKonstanten.WartezeitSound;
               
            when SystemDatentypen.Musik_Ende =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
      if
        EingeleseneMusik.Musik (SystemKonstanten.LeerRasse, 1) = null
      then
         null;
         
      else
         -- Vor dem stoppen noch prüfen ob überhaupt Musik läuft?
         Sf.Audio.Music.stop (music => EingeleseneMusik.Musik (SystemKonstanten.LeerRasse, 1));
         -- destroy ist nötig sonst gibt es die Fehlermeldung "AL lib: (EE) alc_cleanup: 1 device not closed" beim Beenden des Programms.
         Sf.Audio.Music.destroy (music => EingeleseneMusik.Musik (SystemKonstanten.LeerRasse, 1));
      end if;
      
   end MusikSFML;

end MusikSFML;

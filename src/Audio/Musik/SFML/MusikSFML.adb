pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikTonDatentypen;
with ZeitKonstanten;

with InteraktionMusiktask;
with Fehler;
with MusikIntroSFML;
with MusikStartEndeSFML;

package body MusikSFML is

   procedure MusikSFML
   is begin
         
      -- Musik wird direkt parallel aufgerufen. Steht auch im SFML Tutorial, allerdings unter Sound, und der Beschreibung der ASFML.
      -- Beim Abspielen von Musik einfach immer eine Sekunde delayen bevor geprüft wird ob die Musik noch spielt?
      MusikStartEndeSFML.MusikAbspielen;
      
      MusikSchleife:
      loop
         
         case
           InteraktionMusiktask.AktuelleMusik
         is
            when GrafikTonDatentypen.Musik_Konsole_Enum =>
               Fehler.MusikFehler (FehlermeldungExtern => "MusikSFML.MusikSFML - Konsole wird bei SFML aufgerufen.");
               
            when GrafikTonDatentypen.Musik_Intro_Enum =>
               MusikIntroSFML.Intro;
               
            when GrafikTonDatentypen.Musik_SFML_Enum =>
               delay ZeitKonstanten.WartezeitSound;
               
            when GrafikTonDatentypen.Musik_Ende_Enum =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
      MusikStartEndeSFML.MusikStoppen;
      MusikStartEndeSFML.MusikEntfernen;
      
   end MusikSFML;

end MusikSFML;

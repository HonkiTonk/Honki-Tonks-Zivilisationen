pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;

with NachMusiktask;
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
           NachMusiktask.AktuelleMusik
         is
            when TonDatentypen.Musik_Terminal_Enum =>
               Fehler.MusikFehler (FehlermeldungExtern => "MusikSFML.MusikSFML - Terminal bei SFML aufgerufen.");
               
            when TonDatentypen.Musik_Intro_Enum =>
               MusikIntroSFML.Intro;
               
            when TonDatentypen.Musik_SFML_Enum =>
               delay ZeitKonstanten.WartezeitSound;
               
            when TonDatentypen.Musik_Ende_Enum =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
      MusikStartEndeSFML.MusikStoppen;
      MusikStartEndeSFML.MusikEntfernen;
      
   end MusikSFML;

end MusikSFML;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;

with NachMusiktask;
with MusikIntroSFML;
with MusikStartEndeSFML;
with VonLogiktaskAnAlle;

package body MusikSFML is

   procedure MusikSFML
   is begin
      
      EinlesenAbwartenSchleife:
      while VonLogiktaskAnAlle.EinlesenAbgeschlossen = False loop
         
         delay ZeitKonstanten.WartezeitMusik;
         
      end loop EinlesenAbwartenSchleife;
         
      -- Musik wird direkt parallel aufgerufen. Steht auch im SFML Tutorial, allerdings unter Sound, und der Beschreibung der ASFML.
      -- Beim Abspielen von Musik einfach immer eine Sekunde delayen bevor geprüft wird ob die Musik noch spielt?
      MusikStartEndeSFML.MusikAbspielen;
      
      MusikSchleife:
      loop
         
         case
           NachMusiktask.AktuelleMusik
         is
            when TonDatentypen.Musik_Intro_Enum =>
               MusikIntroSFML.Intro;
               
            when TonDatentypen.Musik_Pause_Enum =>
               delay ZeitKonstanten.WartezeitSound;
               
            when TonDatentypen.Musik_Ende_Enum =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
      MusikStartEndeSFML.MusikStoppen;
      MusikStartEndeSFML.MusikEntfernen;
      
   end MusikSFML;

end MusikSFML;

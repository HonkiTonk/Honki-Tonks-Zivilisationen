pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;

with InteraktionSoundtask;
with Fehler;
with SoundStartEndeSFML;

package body SoundSFML is

   procedure SoundSFML
   is begin
      
      -- Sound wird direkt parallel aufgerufen. Steht auch im SFML Tutorial und der Beschreibung der ASFML.
      SoundStartEndeSFML.SoundAbspielen;
      
      SoundSchleife:
      loop
         
         case
           InteraktionSoundtask.AktuellenSoundAbfragen
         is
            when TonDatentypen.Sound_Konsole_Enum =>
               Fehler.SoundFehler (FehlermeldungExtern => "SoundSFML.SoundSFML - Konsole wird bei SFML aufgerufen.");
               
            when TonDatentypen.Sound_SFML_Enum =>
               delay ZeitKonstanten.WartezeitSound;
               
            when TonDatentypen.Sound_Ende_Enum =>
               exit SoundSchleife;
         end case;
         
      end loop SoundSchleife;
      
      SoundStartEndeSFML.SoundStoppen;
      SoundStartEndeSFML.SoundEntfernen;
      
   end SoundSFML;

end SoundSFML;

pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;

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
            when SystemDatentypen.Sound_Konsole =>
               Fehler.SoundStopp (FehlermeldungExtern => "SoundSFML.SoundSFML - Konsole wird bei SFML aufgerufen.");
               
            when SystemDatentypen.Sound_SFML =>
               delay SystemKonstanten.WartezeitSound;
               
            when SystemDatentypen.Sound_Ende =>
               exit SoundSchleife;
         end case;
         
      end loop SoundSchleife;
      
      SoundStartEndeSFML.SoundStoppen;
      SoundStartEndeSFML.SoundEntfernen;
      
   end SoundSFML;

end SoundSFML;

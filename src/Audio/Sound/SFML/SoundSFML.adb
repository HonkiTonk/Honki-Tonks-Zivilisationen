pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;

with InteraktionSoundtask;
with Fehler;

package body SoundSFML is

   procedure SoundSFML
   is begin
      
      SoundSchleife:
      while InteraktionSoundtask.AktuellenSoundAbfragen = SystemDatentypen.Sound_SFML loop
         
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
      
   end SoundSFML;

end SoundSFML;

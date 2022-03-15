pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with SystemKonstanten;

with Fehler;
with InteraktionSoundtask;

package body SoundKonsole is

   procedure SoundKonsole
   is begin
      
      SoundSchleife:
      loop
         
         case
           InteraktionSoundtask.AktuellenSoundAbfragen
         is
            when SystemDatentypen.Sound_Konsole =>
               delay SystemKonstanten.WartezeitSound;
               
            when SystemDatentypen.Sound_SFML =>
               Fehler.SoundFehler (FehlermeldungExtern => "SoundKonsole.SoundKonsole - SFML wird bei Konsole aufgerufen.");
               
            when SystemDatentypen.Sound_Ende =>
               exit SoundSchleife;
         end case;
         
      end loop SoundSchleife;
      
   end SoundKonsole;

end SoundKonsole;

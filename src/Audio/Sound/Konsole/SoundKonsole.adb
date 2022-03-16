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
            when SystemDatentypen.Sound_Konsole_Enum =>
               delay SystemKonstanten.WartezeitSound;
               
            when SystemDatentypen.Sound_SFML_Enum =>
               Fehler.SoundFehler (FehlermeldungExtern => "SoundKonsole.SoundKonsole - SFML wird bei Konsole aufgerufen.");
               
            when SystemDatentypen.Sound_Ende_Enum =>
               exit SoundSchleife;
         end case;
         
      end loop SoundSchleife;
      
   end SoundKonsole;

end SoundKonsole;

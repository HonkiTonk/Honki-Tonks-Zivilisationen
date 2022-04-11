pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikTonDatentypen;
with SonstigesKonstanten;

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
            when GrafikTonDatentypen.Sound_Konsole_Enum =>
               delay SonstigesKonstanten.WartezeitSound;
               
            when GrafikTonDatentypen.Sound_SFML_Enum =>
               Fehler.SoundFehler (FehlermeldungExtern => "SoundKonsole.SoundKonsole - SFML wird bei Konsole aufgerufen.");
               
            when GrafikTonDatentypen.Sound_Ende_Enum =>
               exit SoundSchleife;
         end case;
         
      end loop SoundSchleife;
      
   end SoundKonsole;

end SoundKonsole;

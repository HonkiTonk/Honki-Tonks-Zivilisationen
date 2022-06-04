pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;

with Fehler;
with InteraktionSoundtask;

package body SoundTerminal is

   procedure SoundTerminal
   is begin
      
      SoundSchleife:
      loop
         
         case
           InteraktionSoundtask.AktuellerSound
         is
            when TonDatentypen.Sound_Terminal_Enum =>
               delay ZeitKonstanten.WartezeitSound;
               
            when TonDatentypen.Sound_SFML_Enum =>
               Fehler.SoundFehler (FehlermeldungExtern => "SoundTerminal.SoundTerminal - SFML wird bei Terminal aufgerufen.");
               
            when TonDatentypen.Sound_Ende_Enum =>
               exit SoundSchleife;
         end case;
         
      end loop SoundSchleife;
      
   end SoundTerminal;

end SoundTerminal;

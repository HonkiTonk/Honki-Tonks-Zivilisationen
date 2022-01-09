pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;
with GlobaleVariablen;

with InteraktionSoundtask;

package body StartSound is

   -- Später eine Unterteilung für Musik und Sound machen wie bei Grafik mit Bilddarstellung und Eingabeanzeige?
   procedure StartSound
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            return;
            
         when others =>
            null;
      end case;
      
      SoundSchleife:
      while InteraktionSoundtask.AktuelleMusikAbfragen = SystemDatentypen.Musik_SFML loop
         
         delay SystemKonstanten.WartezeitSound;
         
      end loop SoundSchleife;
      
   end StartSound;

end StartSound;

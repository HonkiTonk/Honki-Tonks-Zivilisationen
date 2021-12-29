pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;
with GlobaleVariablen;

with InteraktionTasks;

package body StartSound is

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
      while InteraktionTasks.AktuelleMusikAbfragen = SystemDatentypen.Musik_SFML loop
         
         delay SystemKonstanten.WartezeitSound;
         
      end loop SoundSchleife;
      
   end StartSound;

end StartSound;

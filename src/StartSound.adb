pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;

with InteraktionTasks;

package body StartSound is

   procedure StartSound
   is begin
      
      SoundSchleife:
      while InteraktionTasks.AktuelleMusik /= SystemDatentypen.Grafik_Ende loop
         
         delay InteraktionTasks.WartezeitSound;
         
      end loop SoundSchleife;
      
   end StartSound;

end StartSound;

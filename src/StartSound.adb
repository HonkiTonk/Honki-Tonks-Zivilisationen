pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;

with SoundWichtigeEinstellungen;

package body StartSound is

   procedure StartSound
   is begin
      
      SoundSchleife:
      while SoundWichtigeEinstellungen.AktuelleMusik /= SystemDatentypen.Grafik_Ende loop
         
         delay SoundWichtigeEinstellungen.Wartezeit;
         
      end loop SoundSchleife;
      
   end StartSound;

end StartSound;

pragma SPARK_Mode (On);

with Sf.Audio.Music;

with EingeleseneMusik;

package body EinlesenMusik is

   procedure EinlesenMusik
   is begin
            
      EingeleseneMusik.MusikTest := Sf.Audio.Music.createFromFile (filename => "Audio/Musik/Test.flac");
      
   end EinlesenMusik;

end EinlesenMusik;

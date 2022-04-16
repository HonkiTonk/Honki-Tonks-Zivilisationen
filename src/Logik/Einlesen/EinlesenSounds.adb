pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with Sf.Audio.SoundBuffer;

with RassenDatentypen;

with EingeleseneSounds;

package body EinlesenSounds is

   procedure EinlesenSounds
   is begin
      
      case
        Exists (Name => "Audio/Sound/Test.flac")
      is
         when False =>
            return;
            
         when True =>
            -- Textdatei mit den Liedernamen einbauen, dann diese einlesen und darauf die Lieder aus der Liste?
            -- Ähnlich der Textdateien.
            EingeleseneSounds.Sound (RassenDatentypen.Keine_Rasse_Enum, 1) := Sf.Audio.SoundBuffer.createFromFile (filename => "Audio/Sound/Test.flac");
      end case;
      
   end EinlesenSounds;

end EinlesenSounds;

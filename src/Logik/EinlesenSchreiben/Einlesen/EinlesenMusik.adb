pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Sf.Audio.Music;

with SystemDatentypen;

with EingeleseneMusik;

package body EinlesenMusik is

   procedure EinlesenMusik
   is begin
      
      case
        Exists (Name => "Audio/Musik/Siedler.flac")
      is
         when False =>
            Put_Line ("1");
            return;
            
         when True =>
            Put_Line ("2");
            -- Textdatei mit den Liedernamen einbauen, dann diese einlesen und darauf die Lieder aus der Liste?
            -- Ähnlich der Textdateien.
            EingeleseneMusik.Musik (SystemDatentypen.Keine_Rasse, 1) := Sf.Audio.Music.createFromFile (filename => "Audio/Musik/Siedler.flac");
      end case;
      
   end EinlesenMusik;

end EinlesenMusik;

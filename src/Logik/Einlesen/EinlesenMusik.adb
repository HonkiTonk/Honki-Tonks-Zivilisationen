pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with Sf.Audio.Music;

with RassenDatentypen;
with TextKonstanten;

with EingeleseneMusik;

package body EinlesenMusik is

   procedure EinlesenMusik
   is begin
      
      case
        Exists (Name => TextKonstanten.Audio & TextKonstanten.Musik & "Test.flac")
      is
         when False =>
            return;
            
         when True =>
            -- Textdatei mit den Liedernamen einbauen, dann diese einlesen und darauf die Lieder aus der Liste?
            -- Ähnlich der Textdateien.
            EingeleseneMusik.Musik (RassenDatentypen.Keine_Rasse_Enum, 1) := Sf.Audio.Music.createFromFile (filename => "Audio/Musik/Test.flac");
      end case;
      
   end EinlesenMusik;

end EinlesenMusik;

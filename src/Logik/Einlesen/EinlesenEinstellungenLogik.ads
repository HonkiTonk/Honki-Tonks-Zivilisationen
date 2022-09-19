pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package EinlesenEinstellungenLogik is

   procedure EinlesenEinstellungen;
   
private
      
   DateiNutzereinstellungen : File_Type;
   DateiGrafikeinstellungen : File_Type;
   DateiSoundeinstellungen : File_Type;
   
   procedure Nutzereinstellungen;
   procedure Grafikeinstellungen;
   procedure Soundeinstelllungen;

end EinlesenEinstellungenLogik;

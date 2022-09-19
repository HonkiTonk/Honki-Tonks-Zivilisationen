pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package SchreibenEinstellungenLogik is

   procedure Nutzereinstellungen;
   procedure Grafikeinstellungen;
   procedure Soundeinstellungen;

private

   DateiNutzereinstellungen : File_Type;
   DateiGrafikeinstellungen : File_Type;
   DateiSoundeinstellungen : File_Type;

end SchreibenEinstellungenLogik;

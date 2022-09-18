pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package SchreibenEinstellungenLogik is

   procedure SchreibenEinstellungen;

private

   DateiEinstellungenSchreiben : File_Type;

end SchreibenEinstellungenLogik;

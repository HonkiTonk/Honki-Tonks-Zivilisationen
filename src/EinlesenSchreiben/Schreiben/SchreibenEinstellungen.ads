pragma SPARK_Mode (On);

with Ada.Streams.Stream_IO;
use Ada.Streams.Stream_IO;

package SchreibenEinstellungen is

   procedure SchreibenEinstellungen;

private

   EinstellungenDatei : File_Type;

end SchreibenEinstellungen;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package SchreibenDatenbanken is

   procedure SchreibenAlleDatenbanken;
   procedure SchreibenEinheitenDatenbank;
   procedure SchreibenForschungsDatenbank;
   procedure SchreibenGebäudeDatenbank;
   procedure SchreibenKartenDatenbank;
   procedure SchreibenVerbesserungenDatenbank;
   procedure SchreibenRassenDatenbank;

private

   DatenbankSpeichern : File_Type;

end SchreibenDatenbanken;

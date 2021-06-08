pragma SPARK_Mode (On);

with Ada.Streams.Stream_IO;
use Ada.Streams.Stream_IO;

package SchreibenWerte is

   procedure SchreibenAlleDatenbanken;

   procedure SchreibenEinheitenDatenbank;

   procedure SchreibenForschungsDatenbank;

   procedure SchreibenGebäudeDatenbank;

   procedure SchreibenKartenDatenbank;

   procedure SchreibenVerbesserungenDatenbank;

private

   EinheitenDatenbankSpeichern : File_Type;
   ForschungsDatenbankSpeichern : File_Type;
   GebäudeDatenbankSpeichern : File_Type;
   KartenDatenbankSpeichern : File_Type;
   VerbesserungenDatenbankSpeichern : File_Type;

end SchreibenWerte;

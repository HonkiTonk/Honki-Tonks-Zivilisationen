pragma SPARK_Mode (On);

with Ada.Streams.Stream_IO;
use Ada.Streams.Stream_IO;

package EinlesenWerte is
   
   procedure EinlesenAlleDatenbanken;
   
   procedure EinlesenEinheitenDatenbank;
   
   procedure EinlesenForschungsDatenbank;
   
   procedure EinlesenGebäudeDatenbank;
   
   procedure EinlesenKartenDatenbank;
   
   procedure EinlesenVerbesserungenDatenbank;
   
private
   
   EinheitenDatenbankEinlesen : File_Type;
   ForschungsDatenbankEinlesen : File_Type;
   GebäudeDatenbankEinlesen : File_Type;
   KartenDatenbankEinlesen : File_Type;
   VerbesserungenDatenbankEinlesen : File_Type;

end EinlesenWerte;

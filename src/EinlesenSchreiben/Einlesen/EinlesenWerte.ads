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
   
   DatenbankEinlesen : File_Type;

end EinlesenWerte;

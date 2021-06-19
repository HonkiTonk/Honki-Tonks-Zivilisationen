pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

package EinlesenEinstellungen is

   procedure EinlesenEinstellungen;
   
private   
   
   LeereZeilenAbzieher : Natural;
   
   DateiEinstellungenEinlesen : File_Type;

end EinlesenEinstellungen;

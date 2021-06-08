pragma SPARK_Mode (On);

with Ada.Streams.Stream_IO;
use Ada.Streams.Stream_IO;

package EinlesenTastatur is
   
   procedure EinlesenTastaturbelegung;
   
private
   
   TastenbelegungLaden : File_Type;

end EinlesenTastatur;

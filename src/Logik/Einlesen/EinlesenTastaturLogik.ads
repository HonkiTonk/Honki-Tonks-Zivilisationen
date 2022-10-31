pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package EinlesenTastaturLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenTastaturbelegung;
   
private
   
   TastenbelegungLaden : File_Type;

end EinlesenTastaturLogik;

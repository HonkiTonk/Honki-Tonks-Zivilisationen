pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package SchreibenTastaturLogik is

   procedure TastenbelegungSchreiben;
   
private
   
   TastenbelegungSpeichern : File_Type;

end SchreibenTastaturLogik;
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package SchreibenTastaturLogik is
   pragma Elaborate_Body;

   procedure TastenbelegungSchreiben;
   
private
   
   TastenbelegungSpeichern : File_Type;

end SchreibenTastaturLogik;

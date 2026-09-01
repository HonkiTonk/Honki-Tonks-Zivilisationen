with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package SpeichernSpeziesLogik is
   pragma Elaborate_Body;

   function Spezieswerte
     (DateiSpeichernExtern : in File_Type)
      return Boolean;
   
private
   
   LadezeitBasis : Float;
   Ladezeit : Float;

end SpeichernSpeziesLogik;

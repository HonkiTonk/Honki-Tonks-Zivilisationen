with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

private with KommazahltestsHTSEB;

package SpeichernSpeziesLogik is
   pragma Elaborate_Body;

   function Spezieswerte
     (DateiSpeichernExtern : in File_Type)
      return Boolean;
   
private
   
   LadezeitBasis : Float;
   Ladezeit : Float;
   
   
   
   function LadezeitTesten is new KommazahltestsHTSEB.StrichrechnungNatural (Kommazahl => SystemDatentypenHTSEB.LadezeitBasis);

end SpeichernSpeziesLogik;

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SpeziesDatentypen;

package SpeichernKarteLogik is
   pragma Elaborate_Body;

   function Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean;
      
private
   
   AnzahlFelder : Natural;
   
   VorhandeneSpezies : SpeziesDatentypen.Speziesnummern;
   
end SpeichernKarteLogik;

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SpeziesDatentypen;

package SpeichernKarteLogik is
   pragma Elaborate_Body;

   function Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean;
      
private
   
   FelderanzahlZusatzgrund : Positive;
   FelderanzahlSichtbarkeit : Positive;
   GesamteFelderanzahl : Positive;
   
   GesamtgrößeSpezieszusammenfassung : Natural;
   
   VorhandeneSpezies : SpeziesDatentypen.SpeziesnummernVorhanden;
   
   ByteanzahlAchtFelderzusammenfassung : Float;
   
   
   
   function AchtFelderzusammenfassung
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean;
   
   function Spezieszusammenfassung
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean;
   
end SpeichernKarteLogik;

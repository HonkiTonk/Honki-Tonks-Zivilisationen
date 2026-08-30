with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SpeziesDatentypen;
private with KartenArrays;

package SpeichernKarteLogik is
   pragma Elaborate_Body;

   function Karte
     (DateiSpeichernExtern : in File_Type)
      return Boolean;
      
private
   
   FelderanzahlZusatzgrund : Positive;
   FelderanzahlSichtbarkeit : Positive;
   GesamteFelderanzahl : Positive;
   
   GesamtgrößeSpezieszusammenfassung : Natural;
   
   VorhandeneSpezies : SpeziesDatentypen.SpeziesnummernVorhanden;
   
   ByteanzahlAchtFelderzusammenfassung : Float;
   SpeicherzeitKarteBasiswert : Float;
   SpeicherzeitKarte : Float;
   
   SichtbarkeitFelderreiheFestgelegt : KartenArrays.SichtbarkeitGesamtArray;
   
   
      
   function Felderzusammenfassung
     (DateiSpeichernExtern : in File_Type)
      return Boolean;
   
   function Spezieszusammenfassung
     (DateiSpeichernExtern : in File_Type)
      return Boolean;
   
end SpeichernKarteLogik;

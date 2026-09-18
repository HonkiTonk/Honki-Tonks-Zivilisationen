with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SpeziesDatentypen;
private with KartenArrays;
private with KartenRecords;
private with KartenDatentypen;

package SpeichernKarteLogik is
   pragma Elaborate_Body;

   function Karte
     (DateiSpeichernExtern : in File_Type)
      return Boolean;
      
private
   use type KartenDatentypen.EbeneBasis;
   
   VorhandeneSpezies : SpeziesDatentypen.SpeziesnummernVorhanden;
   
   FelderanzahlZusatzgrund : Positive;
   FelderanzahlSichtbarkeit : Positive;
   GesamteFelderanzahl : Positive;
   
   GesamtgrößeSpezieszusammenfassung : Natural;
   
   ByteanzahlAchtFelderzusammenfassung : Float;
   SpeicherzeitKarteBasiswert : Float;
   SpeicherzeitSichtbarkeitBasiswert : Float;
   
   Ebenen : KartenRecords.KartenebenenVorhandenRecord;
   
   SichtbarkeitFelderreiheFestgelegt : KartenArrays.SichtbarkeitGesamtArray;
   
   
      
   function Felderzusammenfassung
     (DateiSpeichernExtern : in File_Type;
      EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
      return Boolean
     with
       Pre => (
                EbenenExtern.EbeneAnfang <= EbenenExtern.EbeneEnde 
              );
   
   function Spezieszusammenfassung
     (DateiSpeichernExtern : in File_Type;
      EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
      return Boolean
     with
       Pre => (
                EbenenExtern.EbeneAnfang <= EbenenExtern.EbeneEnde 
              );
   
end SpeichernKarteLogik;

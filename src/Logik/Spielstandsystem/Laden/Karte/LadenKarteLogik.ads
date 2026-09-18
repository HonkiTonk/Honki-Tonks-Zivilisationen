with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

private with KartenRecords;
private with SpeziesDatentypen;
private with KartenArrays;
private with KartenDatentypen;

package LadenKarteLogik is
   pragma Elaborate_Body;

   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   use type KartenDatentypen.EbeneBasis;
   
   FelderanzahlZusatzgrund : Positive;
   FelderanzahlSichtbarkeit : Positive;
   
   SichtbarkeitLadeaufteilung : SystemDatentypenHTSEB.EinByte;
   
   VorhandeneSpezies : SpeziesDatentypen.SpeziesnummernBasis;
   
   Speziesbelegung : SpeziesDatentypen.Spezies_Vorhanden_Enum;
   
   LadezeitKarteBasiswert : Float;
   LadezeitSichtbarkeitBasiswert : Float;
   
   Ebenen : KartenRecords.KartenebenenVorhandenRecord;

   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord;
         
   KoordinatenFestgelegt : KartenArrays.SichtbarkeitKoordinatenArray;
   KoordinatenBestimmen : KartenArrays.SichtbarkeitKoordinatenArray;
   
   
   
   function Felderzusammenfassung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type;
      KarteneinstellungenExtern : in KartenRecords.PermanenteKartenparameterRecord;
      EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
      return Boolean
     with
       Pre => (
                EbenenExtern.EbeneAnfang <= EbenenExtern.EbeneEnde 
              );
   
   function Spezieszusammenfassung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type;
      KarteneinstellungenExtern : in KartenRecords.PermanenteKartenparameterRecord;
      EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
      return Boolean
     with
       Pre => (
                EbenenExtern.EbeneAnfang <= EbenenExtern.EbeneEnde 
              );

end LadenKarteLogik;

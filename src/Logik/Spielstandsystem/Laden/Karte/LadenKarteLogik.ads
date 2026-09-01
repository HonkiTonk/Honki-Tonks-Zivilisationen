with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

private with KartenRecords;
private with SpeziesDatentypen;
private with KartenArrays;

package LadenKarteLogik is
   pragma Elaborate_Body;

   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   
   FelderanzahlZusatzgrund : Positive;
   FelderanzahlSichtbarkeit : Positive;
   
   SichtbarkeitLadeaufteilung : SystemDatentypenHTSEB.EinByte;
   
   VorhandeneSpezies : SpeziesDatentypen.SpeziesnummernBasis;
   
   Speziesbelegung : SpeziesDatentypen.Spezies_Vorhanden_Enum;
   
   LadezeitKarteBasiswert : Float;
   LadezeitKarte : Float;
   LadezeitSichtbarkeitBasiswert : Float;
   LadezeitSichtbarkeit : Float;

   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord;
         
   KoordinatenFestgelegt : KartenArrays.SichtbarkeitKoordinatenArray;
   KoordinatenBestimmen : KartenArrays.SichtbarkeitKoordinatenArray;
   
   
   
   function Felderzusammenfassung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
   function Spezieszusammenfassung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
   function Ladezeittest
     (BasiswertExtern : in Float;
      ZusatzwertExtern : in Float)
      return Float
     with
       Pre => (
                 BasiswertExtern in 0.00 .. 100.00
               and
                 ZusatzwertExtern in 0.00 .. 100.00
              ),
         
       Post => (
                  Ladezeittest'Result in 0.00 .. 100.00
               );

end LadenKarteLogik;

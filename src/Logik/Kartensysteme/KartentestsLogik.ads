with KartenDatentypen;
with KartenartDatentypen;
with KartenRecords;

package KartentestsLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   procedure Größenanpassung;



   function SenkrechteKartenpolePrüfen
     (PolgrößeExtern : in KartenDatentypen.SenkrechteNatural)
      return KartenartDatentypen.Kartenpole_Enum
     with
       Pre => (
                 PolgrößeExtern <= KartenDatentypen.SenkrechteNatural'Last / 2
              );

   function WaagerechteKartenpolePrüfen
     (PolgrößeExtern : in KartenDatentypen.WaagerechteNatural)
      return KartenartDatentypen.Kartenpole_Enum
     with
       Pre => (
                 PolgrößeExtern <= KartenDatentypen.WaagerechteNatural'Last / 2
              );

   function VorhandeneEbenen
     (EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
      return KartenDatentypen.SenkrechtePositiv
     with
       Post => (
                  VorhandeneEbenen'Result <= 5
               );

   function PlanetenEbenen
     (EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
      return KartenDatentypen.SenkrechtePositiv
     with
       Post => (
                  PlanetenEbenen'Result <= 3
               );

end KartentestsLogik;

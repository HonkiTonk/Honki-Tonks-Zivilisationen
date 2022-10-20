pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenartDatentypen;

package KartentestsLogik is

   procedure Größenanpassung;



   function KartenpolePrüfen
     (PolgrößeExtern : in KartenDatentypen.KartenfeldNatural)
      return KartenartDatentypen.Kartenpole_Enum
     with
       Pre => (
                 PolgrößeExtern <= KartenDatentypen.KartenfeldNatural'Last / 2
              );

end KartentestsLogik;

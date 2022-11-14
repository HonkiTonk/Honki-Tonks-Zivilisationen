with KartenDatentypen;
with KartenartDatentypen;

package KartentestsLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   procedure Größenanpassung;



   function KartenpolePrüfen
     (PolgrößeExtern : in KartenDatentypen.KartenfeldNatural)
      return KartenartDatentypen.Kartenpole_Enum
     with
       Pre => (
                 PolgrößeExtern <= KartenDatentypen.KartenfeldNatural'Last / 2
              );

end KartentestsLogik;

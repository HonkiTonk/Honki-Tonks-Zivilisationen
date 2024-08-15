with KartenDatentypen;
with KartenartDatentypen;

package KartentestsLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;

   procedure Größenanpassung;



   function KartenpolePrüfen
     (PolgrößeExtern : in KartenDatentypen.SenkrechteNatural)
      return KartenartDatentypen.Kartenpole_Enum
     with
       Pre => (
                 PolgrößeExtern <= KartenDatentypen.SenkrechteNatural'Last / 2
              );

end KartentestsLogik;

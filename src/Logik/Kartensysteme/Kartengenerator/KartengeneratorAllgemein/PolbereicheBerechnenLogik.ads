private with KartenDatentypen;

package PolbereicheBerechnenLogik is
   pragma Elaborate_Body;

   procedure PolbereicheBerechnen;
   
private
   
   PolbereichNorden : KartenDatentypen.KartenfeldNatural;
   PolbereichSüden : KartenDatentypen.KartenfeldNatural;
   PolbereichWesten : KartenDatentypen.KartenfeldNatural;
   PolbereichOsten : KartenDatentypen.KartenfeldNatural;

end PolbereicheBerechnenLogik;

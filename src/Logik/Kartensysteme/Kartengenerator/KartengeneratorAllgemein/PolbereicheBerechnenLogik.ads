private with KartenDatentypen;

package PolbereicheBerechnenLogik is
   pragma Elaborate_Body;

   procedure PolbereicheBerechnen;
   
private
   
   PolbereichNorden : KartenDatentypen.SenkrechteNatural;
   PolbereichSüden : KartenDatentypen.SenkrechteNatural;
   PolbereichWesten : KartenDatentypen.SenkrechteNatural;
   PolbereichOsten : KartenDatentypen.SenkrechteNatural;

end PolbereicheBerechnenLogik;

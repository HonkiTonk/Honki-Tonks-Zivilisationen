pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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

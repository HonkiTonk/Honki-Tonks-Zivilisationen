pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with KartenDatentypen;

package PolbereicheBerechnen is

   procedure PolbereicheBerechnen;
   
private
   
   PolbereichNorden : KartenDatentypen.KartenfeldNatural;
   PolbereichSüden : KartenDatentypen.KartenfeldNatural;
   PolbereichWesten : KartenDatentypen.KartenfeldNatural;
   PolbereichOsten : KartenDatentypen.KartenfeldNatural;

end PolbereicheBerechnen;

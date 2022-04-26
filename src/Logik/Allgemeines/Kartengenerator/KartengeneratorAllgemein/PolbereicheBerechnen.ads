pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

package PolbereicheBerechnen is

   procedure PolbereicheBerechnen;
   
private
   
   PolbereichNorden : KartenDatentypen.KartenfeldPositivMitNullwert;
   PolbereichSüden : KartenDatentypen.KartenfeldPositivMitNullwert;
   PolbereichWesten : KartenDatentypen.KartenfeldPositivMitNullwert;
   PolbereichOsten : KartenDatentypen.KartenfeldPositivMitNullwert;

end PolbereicheBerechnen;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;

package KartengeneratorPolregion is

   procedure PolregionGenerieren;

private

   SüdpolSchleifenkorrektur : KartenDatentypen.KartenfeldPositivMitNullwert;
   OstpolSchleifenkorrektur : KartenDatentypen.KartenfeldPositivMitNullwert;

   procedure PolregionNorden;
   procedure PolregionSüden;
   procedure PolregionWesten;
   procedure PolregionOsten;

end KartengeneratorPolregion;

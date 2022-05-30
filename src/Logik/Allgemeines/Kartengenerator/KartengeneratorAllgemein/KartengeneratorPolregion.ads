pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;

package KartengeneratorPolregion is

   procedure PolregionGenerieren;

private

   SüdpolSchleifenkorrektur : KartenDatentypen.KartenfeldNatural;
   OstpolSchleifenkorrektur : KartenDatentypen.KartenfeldNatural;

   procedure PolregionNorden;
   procedure PolregionSüden;
   procedure PolregionWesten;
   procedure PolregionOsten;

end KartengeneratorPolregion;

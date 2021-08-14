pragma SPARK_Mode (On);

with GlobaleDatentypen;

package KartenGeneratorPlanetenInneres is

   procedure PlanetenInneres;

private

   YKernanfang : GlobaleDatentypen.KartenfeldPositiv;
   XKernanfang : GlobaleDatentypen.KartenfeldPositiv;
   YKernende : GlobaleDatentypen.KartenfeldPositiv;
   XKernende : GlobaleDatentypen.KartenfeldPositiv;

end KartenGeneratorPlanetenInneres;

pragma SPARK_Mode (On);

with GlobaleDatentypen;

package KartenGeneratorPlanetenInneres is

   procedure PlanetenInneres;

private

   YKernanfang : KartenDatentypen.KartenfeldPositiv;
   XKernanfang : KartenDatentypen.KartenfeldPositiv;
   YKernende : KartenDatentypen.KartenfeldPositiv;
   XKernende : KartenDatentypen.KartenfeldPositiv;

end KartenGeneratorPlanetenInneres;

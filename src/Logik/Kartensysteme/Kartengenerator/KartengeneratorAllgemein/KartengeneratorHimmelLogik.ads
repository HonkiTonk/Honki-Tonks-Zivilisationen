pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with KartenDatentypen;

package KartengeneratorHimmelLogik is

   procedure Himmel;

private

   Kartenzeitwert : KartenDatentypen.KartenfeldNatural;

end KartengeneratorHimmelLogik;
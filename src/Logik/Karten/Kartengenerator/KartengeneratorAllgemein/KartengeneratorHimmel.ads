pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with KartenDatentypen;

package KartengeneratorHimmel is

   procedure Himmel;

private

   Kartenzeitwert : KartenDatentypen.KartenfeldNatural;

end KartengeneratorHimmel;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ZahlenDatentypen;

package KartengeneratorHimmel is

   procedure Himmel;

private

   Multiplikator : ZahlenDatentypen.EigenesPositive;

end KartengeneratorHimmel;

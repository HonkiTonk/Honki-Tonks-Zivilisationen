pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with ZahlenDatentypen;

package KartengeneratorWeltraum is

   procedure Weltraum;

private

   Multiplikator : ZahlenDatentypen.EigenesPositive;

end KartengeneratorWeltraum;

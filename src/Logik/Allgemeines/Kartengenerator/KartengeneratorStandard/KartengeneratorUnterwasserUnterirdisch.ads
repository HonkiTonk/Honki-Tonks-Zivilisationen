pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with ZahlenDatentypen;

package KartengeneratorUnterwasserUnterirdisch is

   procedure GenerierungLandschaft;

private

   Multiplikator : ZahlenDatentypen.EigenesPositive;

end KartengeneratorUnterwasserUnterirdisch;

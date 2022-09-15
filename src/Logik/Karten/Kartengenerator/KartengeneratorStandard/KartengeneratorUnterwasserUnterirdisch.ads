pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with KartenDatentypen;

package KartengeneratorUnterwasserUnterirdisch is

   procedure GenerierungLandschaft;

private

   Kartenzeitwert : KartenDatentypen.KartenfeldNatural;

end KartengeneratorUnterwasserUnterirdisch;

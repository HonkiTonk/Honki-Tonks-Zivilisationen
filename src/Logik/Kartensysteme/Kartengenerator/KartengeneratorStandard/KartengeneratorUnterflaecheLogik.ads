pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with KartenDatentypen;

package KartengeneratorUnterflaecheLogik is

   procedure GenerierungLandschaft;

private

   Kartenzeitwert : KartenDatentypen.KartenfeldNatural;

end KartengeneratorUnterflaecheLogik;

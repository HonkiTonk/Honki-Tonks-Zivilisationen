pragma SPARK_Mode (On);

with KartenRecords, KartenDatentypen;
use KartenDatentypen;

with KartenGeneratorBerechnungenAllgemein;

package KartenGeneratorUnterwasserUnterirdisch is

   procedure UnterwasserUnterirdisch;

private

   AnzahlGleicherGrund : KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   type KartengrundWahrscheinlichkeitenArray is array (KartenDatentypen.Karten_Unterwasser_Generator_Enum'Range, KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder'Range) of Float;
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray :=
     (
      KartenDatentypen.Korallen =>
        (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.25, 4 => 0.30, 5 => 0.30, 6 => 0.30, 7 => 0.40, 8 => 0.55),
      KartenDatentypen.Unterwasser_Wald =>
        (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.25, 4 => 0.30, 5 => 0.30, 6 => 0.30, 7 => 0.40, 8 => 0.55)
     );

   procedure WasserweltErzeugen
     (YPositionExtern : in KartenDatentypen.KartenfeldPositiv;
      XPositionExtern : in KartenDatentypen.KartenfeldPositiv);

   procedure ErdweltErzeugen
     (YPositionExtern : in KartenDatentypen.KartenfeldPositiv;
      XPositionExtern : in KartenDatentypen.KartenfeldPositiv);

   procedure GrundErzeugen
     (YPositionExtern : in KartenDatentypen.KartenfeldPositiv;
      XPositionExtern : in KartenDatentypen.KartenfeldPositiv);

end KartenGeneratorUnterwasserUnterirdisch;

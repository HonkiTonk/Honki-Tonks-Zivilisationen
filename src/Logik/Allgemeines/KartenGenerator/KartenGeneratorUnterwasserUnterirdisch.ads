pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen;
with KartenRecords;

with KartenGeneratorBerechnungenAllgemein;

package KartenGeneratorUnterwasserUnterirdisch is

   procedure UnterwasserUnterirdisch;

private

   AnzahlGleicherGrund : KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   type KartengrundWahrscheinlichkeitenArray is array (KartenGrundDatentypen.Karten_Unterwasser_Generator_Enum'Range, KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder'Range) of Float;
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray := (
                                                                                       KartenGrundDatentypen.Korallen_Enum =>
                                                                                         (0 => 0.20,
                                                                                          1 => 0.25,
                                                                                          2 => 0.25,
                                                                                          3 => 0.25,
                                                                                          4 => 0.30,
                                                                                          5 => 0.30,
                                                                                          6 => 0.30,
                                                                                          7 => 0.40,
                                                                                          8 => 0.55),

                                                                                       KartenGrundDatentypen.Unterwasser_Wald_Enum =>
                                                                                         (0 => 0.20,
                                                                                          1 => 0.25,
                                                                                          2 => 0.25,
                                                                                          3 => 0.25,
                                                                                          4 => 0.30,
                                                                                          5 => 0.30,
                                                                                          6 => 0.30,
                                                                                          7 => 0.40,
                                                                                          8 => 0.55)
                                                                                      );

   procedure WasserweltErzeugen
     (YXAchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord);

   procedure ErdweltErzeugen
     (YXAchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord);

   procedure GrundErzeugen
     (YXAchsenExtern : in KartenRecords.YXAchsenKartenfeldPositivRecord);

end KartenGeneratorUnterwasserUnterirdisch;

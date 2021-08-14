pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;

package KartenGeneratorUnterwasserUnterirdisch is

   procedure UnterwasserUnterirdisch;

private

   type AnzahlGleicherFelder is range 0 .. 8;
   AnzahlGleicherGrund : AnzahlGleicherFelder;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

   type KartengrundWahrscheinlichkeitenArray is array (GlobaleDatentypen.Karten_Unterwasser_Generator_Enum'Range, AnzahlGleicherFelder'Range) of Float;
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray :=
     (
      GlobaleDatentypen.Korallen =>
        (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.25, 4 => 0.30, 5 => 0.30, 6 => 0.30, 7 => 0.40, 8 => 0.55),
      GlobaleDatentypen.Unterwasser_Wald =>
        (0 => 0.20, 1 => 0.25, 2 => 0.25, 3 => 0.25, 4 => 0.30, 5 => 0.30, 6 => 0.30, 7 => 0.40, 8 => 0.55)
     );

   procedure WasserweltErzeugen
     (YPositionExtern, XPositionExtern : in GlobaleDatentypen.KartenfeldPositiv);

   procedure ErdweltErzeugen
     (YPositionExtern, XPositionExtern : in GlobaleDatentypen.KartenfeldPositiv);

end KartenGeneratorUnterwasserUnterirdisch;

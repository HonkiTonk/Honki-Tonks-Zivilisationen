pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleKonstanten;
use GlobaleDatentypen;

package Karten is

   type WeltkarteArray is array (GlobaleDatentypen.EbeneVorhanden'Range, GlobaleDatentypen.KartenfeldPositiv'Range, GlobaleDatentypen.KartenfeldPositiv'Range) of GlobaleRecords.KartenRecord;
   Weltkarte : WeltkarteArray := (others => (others => (others => GlobaleKonstanten.LeererWertWeltkarte)));

   type StadtkarteArray is array (GlobaleDatentypen.Stadtfeld'Range, GlobaleDatentypen.Stadtfeld'Range) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   type KartengrößenRecord is record

      YAchsenGröße : GlobaleDatentypen.KartenfeldPositiv;
      XAchsenGröße : GlobaleDatentypen.KartenfeldPositiv;
      Ressourcenmenge : Natural;

   end record;

   type KartengrößenArray is array (1 .. 10) of KartengrößenRecord;
   Kartengrößen : KartengrößenArray := ((20, 20, 12), (40, 40, 50), (80, 80, 200), (120, 80, 300), (120, 160, 600), (160, 160, 800), (240, 240, 1_800), (320, 320, 3200), (1_000, 1_000, 31_250), (1, 1, 1));

   Kartengröße : Positive;

   type GrößeLandartArray is array (1 .. 4) of GlobaleDatentypen.KartenfeldPositiv;
   GrößeLandart : GrößeLandartArray; -- Inseln, Kontinente, Pangäa
                                         -- GrößeLandart bekommt erst innerhalb der Kartengenerierung Werte, da sonst die Werte für Pangäa nicht bekannt wären.

   Kartenart : Positive := 1; -- 1 = Inseln, 2 = Kontinente, 3 = Pangäa, 4 = Nur Land, 5 = Chaos
   Kartentemperatur : Positive := 1; -- 1 = Kalt, 2 = Gemäßigt, 3 = Heiß, 4 = Eiszeit, 5 = Wüste

   type GeneratorKarteArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of GlobaleDatentypen.Kartenfeld;
   GeneratorKarte : GeneratorKarteArray;

   type GeneratorGrundArray is array (Karten.Weltkarte'Range (2), Karten.Weltkarte'Range (3)) of Boolean;
   GeneratorGrund : GeneratorGrundArray;

end Karten;

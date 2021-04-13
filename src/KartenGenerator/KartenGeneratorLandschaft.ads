pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorLandschaft is

   procedure GenerierungLandschaft;

private

   HügelGebirgeUmgebung : Natural;

   BeliebigerLandschaftwert : Float;
   BeliebigerLandschaftFeldwert : Float;
   BeliebigerHügelwert : Float;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   KartenWertHügel : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

   type KartengrundWahrscheinlichkeitenArray is array (1 .. 5, 4 .. 10) of Float; -- 1 = Kalt, 2 = Gemäßigt, 3 = Heiß, 4 = Eiszeit, 5 = Wüste
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray := (1 => (0.25, 0.35, 0.45, 0.55, 0.70, 0.75, 0.85),
                                                                                       -- 4 = Tundra, 5 = Wüste, 6 = Hügel, 7 = Gebirge, 8 = Wald, 9 = Dschungel, 10 = Sumpf
                                                                                       2 => (0.15, 0.30, 0.40, 0.50, 0.70, 0.75, 0.85),
                                                                                       3 => (0.05, 0.35, 0.45, 0.50, 0.65, 0.70, 0.90),
                                                                                       4 => (0.40, 0.44, 0.45, 0.55, 0.70, 0.71, 0.80),
                                                                                       5 => (0.00, 0.50, 0.55, 0.60, 0.70, 0.75, 0.95));
   
   procedure GenerierungLandschaftFelder
     (GrundExtern : in GlobaleDatentypen.KartenGrund;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (GrundExtern > 0
          and
            YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandschaftHügel
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartenGeneratorLandschaft;

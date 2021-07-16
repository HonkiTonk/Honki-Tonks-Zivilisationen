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

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWertHügel : GlobaleRecords.AchsenKartenfeldPositivRecord;

   type KartengrundWahrscheinlichkeitenArray is array (GlobaleDatentypen.Kartentemperatur_Verwendet_Enum'Range, 4 .. 10) of Float;
   KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray := (
                                                                                       -- 2. Dimension: 4 = Tundra, 5 = Wüste, 6 = Hügel, 7 = Gebirge, 8 = Wald, 9 = Dschungel, 10 = Sumpf
                                                                                       GlobaleDatentypen.Kalt => 
                                                                                         (
                                                                                          4 => 0.25,
                                                                                          5 => 0.35,
                                                                                          6 => 0.45,
                                                                                          7 => 0.55,
                                                                                          8 => 0.70,
                                                                                          9 => 0.75,
                                                                                          10 => 0.85),
                                                                                       
                                                                                       GlobaleDatentypen.Gemäßigt =>
                                                                                         (
                                                                                          4 => 0.15,
                                                                                          5 => 0.30,
                                                                                          6 => 0.40,
                                                                                          7 => 0.50,
                                                                                          8 => 0.70,
                                                                                          9 => 0.75,
                                                                                          10 => 0.85),
                                                                                       
                                                                                       GlobaleDatentypen.Heiß =>
                                                                                         (
                                                                                          4 => 0.05,
                                                                                          5 => 0.35,
                                                                                          6 => 0.45,
                                                                                          7 => 0.50,
                                                                                          8 => 0.65,
                                                                                          9 => 0.70,
                                                                                          10 => 0.90),
                                                                                       
                                                                                       GlobaleDatentypen.Eiszeit =>
                                                                                         (
                                                                                          4 => 0.40,
                                                                                          5 => 0.44,
                                                                                          6 => 0.45,
                                                                                          7 => 0.55,
                                                                                          8 => 0.70,
                                                                                          9 => 0.71,
                                                                                          10 => 0.80),
                                                                                       
                                                                                       GlobaleDatentypen.Wüste =>
                                                                                         (
                                                                                          4 => 0.00,
                                                                                          5 => 0.50,
                                                                                          6 => 0.55,
                                                                                          7 => 0.60,
                                                                                          8 => 0.70,
                                                                                          9 => 0.75,
                                                                                          10 => 0.95)
                                                                                      );
   
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

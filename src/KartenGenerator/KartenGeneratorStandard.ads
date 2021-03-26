pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorStandard is

   procedure StandardKarte;

private

   BeliebigerLandwert : Float;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   
   procedure GenerierungKartenart (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasse (YPositionLandmasseExtern, XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => (YPositionLandmasseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XPositionLandmasseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungLandmasseÜberhang (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv; GezogenExtern : in Float) with
     Pre => (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure GenerierungPangäa (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => (YAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchseExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartenGeneratorStandard;

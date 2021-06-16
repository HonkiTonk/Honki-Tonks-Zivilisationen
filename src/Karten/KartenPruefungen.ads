pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;
use Karten;

package KartenPruefungen is

   function KartenPositionBestimmen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      ZusatzYAbstandExtern : in GlobaleDatentypen.Kartenfeld)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            ZusatzYAbstandExtern >= 0),
         Post => -- Kann noch besser geschrieben werden
           ((if
                      KartenPositionBestimmen'Result.YAchse = 0
                        then
                          KartenPositionBestimmen'Result.XAchse = 0)
            and
              (if
                         KartenPositionBestimmen'Result.XAchse = 0
                           then
                             KartenPositionBestimmen'Result.YAchse = 0)
            and
              KartenPositionBestimmen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionBestimmen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function KartenGrund
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

private
   
   ÜberhangXAchse : Integer;
   ÜberhangYAchse : Integer;

end KartenPruefungen;

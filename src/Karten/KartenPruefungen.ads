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
      return GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord
     with
       Pre => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and ZusatzYAbstandExtern >= 0);
   
   function KartenGrund
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

private
   
   Überhang : Integer;

end KartenPruefungen;

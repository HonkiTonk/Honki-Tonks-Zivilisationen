pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;
use Karten;

package KartenPruefungen is

   function KartenPositionBestimmen (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord; Änderung : in GlobaleRecords.AchsenKartenfeldRecord;
                                     ZusatzYAbstand : in GlobaleDatentypen.Kartenfeld) return GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord with
     Pre => ((if Karten.Kartengröße /= 10 then Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)
             and (if Karten.Kartengröße /= 10 then Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and ZusatzYAbstand >= 0));
   
   function KartenGrund (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Boolean with
     Pre => ((if Karten.Kartengröße /= 10 then Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)
             and (if Karten.Kartengröße /= 10 then Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

private
   
   Überhang : Integer;

end KartenPruefungen;

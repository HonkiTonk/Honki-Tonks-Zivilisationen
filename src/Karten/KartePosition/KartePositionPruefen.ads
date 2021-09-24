pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten, KartenRecords;
use GlobaleDatentypen;

with Karten;
use Karten;

package KartePositionPruefen is
   
   function KartenPositionBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           ((if
                      KartenPositionBestimmen'Result.YAchse = GlobaleKonstanten.LeerYXKartenWert
                        then
              (KartenPositionBestimmen'Result.XAchse = GlobaleKonstanten.LeerYXKartenWert
               and
                 KartenPositionBestimmen'Result.EAchse = GlobaleDatentypen.EbeneVorhanden'First)
           )
            and
              (if
                         KartenPositionBestimmen'Result.XAchse = GlobaleKonstanten.LeerYXKartenWert
                           then
                 (KartenPositionBestimmen'Result.YAchse = GlobaleKonstanten.LeerYXKartenWert
                  and
                    KartenPositionBestimmen'Result.EAchse = GlobaleDatentypen.EbeneVorhanden'First))
            and
              KartenPositionBestimmen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionBestimmen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartePositionPruefen;

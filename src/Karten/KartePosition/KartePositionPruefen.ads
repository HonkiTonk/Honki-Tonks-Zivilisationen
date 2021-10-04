pragma SPARK_Mode (On);

with KartenRecords, KartenKonstanten, KartenDatentypen;
use KartenDatentypen;

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
                      KartenPositionBestimmen'Result.YAchse = KartenKonstanten.LeerYAchse
                        then
              (KartenPositionBestimmen'Result.XAchse = KartenKonstanten.LeerXAchse
               and
                 KartenPositionBestimmen'Result.EAchse = KartenDatentypen.EbeneVorhanden'First)
           )
            and
              (if
                         KartenPositionBestimmen'Result.XAchse = KartenKonstanten.LeerXAchse
                           then
                 (KartenPositionBestimmen'Result.YAchse = KartenKonstanten.LeerYAchse
                  and
                    KartenPositionBestimmen'Result.EAchse = KartenDatentypen.EbeneVorhanden'First))
            and
              KartenPositionBestimmen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionBestimmen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartePositionPruefen;

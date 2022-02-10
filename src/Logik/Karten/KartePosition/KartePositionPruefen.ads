pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with KartenKonstanten;

with Karten; use Karten;

package KartePositionPruefen is
   
   function KartenPositionBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
   -- Die Contracts hier mal überarbeiten, sind unvollständig und vielleicht auch zu lang?
   -- Vielleicht sollte man die Contracts auch überarbeiten, wenn man das System an sich überarbeitet?
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
               KartenPositionBestimmen'Result.EAchse = KartenKonstanten.LeerEAchse)
         )
          and
            (if
                     KartenPositionBestimmen'Result.XAchse = KartenKonstanten.LeerXAchse
                       then
               (KartenPositionBestimmen'Result.YAchse = KartenKonstanten.LeerYAchse
                and
                  KartenPositionBestimmen'Result.EAchse = KartenKonstanten.LeerEAchse)
            )
          and
            (if
                     KartenPositionBestimmen'Result.EAchse = KartenKonstanten.LeerEAchse
                       then
               (KartenPositionBestimmen'Result.YAchse = KartenKonstanten.LeerYAchse
                and
                  KartenPositionBestimmen'Result.XAchse = KartenKonstanten.LeerXAchse)
            )
          and
            KartenPositionBestimmen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KartenPositionBestimmen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartePositionPruefen;

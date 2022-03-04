pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with KartenKonstanten;

with Karten; use Karten;

package KarteKoordinatenPruefen is
   
   function KarteKoordinatenPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
           
         Post =>
           ((if
                      KarteKoordinatenPrüfen'Result.YAchse = KartenKonstanten.LeerYAchse
                        then
              (KarteKoordinatenPrüfen'Result.XAchse = KartenKonstanten.LeerXAchse
               and
                 KarteKoordinatenPrüfen'Result.EAchse = KartenKonstanten.LeerEAchse)
           )
            and
              (if
                         KarteKoordinatenPrüfen'Result.XAchse = KartenKonstanten.LeerXAchse
                           then
                 (KarteKoordinatenPrüfen'Result.YAchse = KartenKonstanten.LeerYAchse
                  and
                    KarteKoordinatenPrüfen'Result.EAchse = KartenKonstanten.LeerEAchse)
              )
            and
              (if
                         KarteKoordinatenPrüfen'Result.EAchse = KartenKonstanten.LeerEAchse
                           then
                 (KarteKoordinatenPrüfen'Result.YAchse = KartenKonstanten.LeerYAchse
                  and
                    KarteKoordinatenPrüfen'Result.XAchse = KartenKonstanten.LeerXAchse)
              )
            and
              KarteKoordinatenPrüfen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KarteKoordinatenPrüfen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
private
   
   type NeueKoordinateArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   NeueKoordinate : NeueKoordinateArray;
   
   function YAchsePrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert;
   
   function XAchsePrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert;

end KarteKoordinatenPruefen;

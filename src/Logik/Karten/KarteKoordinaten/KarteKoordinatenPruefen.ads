pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with KartenKonstanten;

with Karten; use Karten;

-- Die Arrays sind da wegen der Parallelisierung der Kartenfelderbewertung und weil das hier von Logik und Grafik benötigt wird.
package KarteKoordinatenPruefen is
   
   function KarteKoordinatenPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße),
           
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
              KarteKoordinatenPrüfen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
            and
              KarteKoordinatenPrüfen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);
   
private
   
   type PositionFeldArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.KartenfeldPositivMitNullwert;
   YAchseZwischenwert : PositionFeldArray;
   XAchseZwischenwert : PositionFeldArray;
   
   type NeueKoordinateArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   NeueKoordinate : NeueKoordinateArray;
   
   function EAchsePrüfen
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene;
   
   function YAchsePrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungYXAchseExtern : in KartenRecords.YXAchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert;
   
   function YAchsePrüfenEinzelform
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert;
   
   function XAchsePrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungYXAchseExtern : in KartenRecords.YXAchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert;
   
   function XAchsePrüfenEinzelform
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert;

end KarteKoordinatenPruefen;

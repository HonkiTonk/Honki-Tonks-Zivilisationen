pragma SPARK_Mode (On);

with GlobaleDatentypen, KartenRecords, KartenDatentypen;
use GlobaleDatentypen, KartenDatentypen;

with Karten;

package KartenGeneratorKueste is

   procedure GenerierungKüstenSeeGewässer;

private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartenGeneratorKueste;

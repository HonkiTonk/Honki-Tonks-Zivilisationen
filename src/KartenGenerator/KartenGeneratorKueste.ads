pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorKueste is

   procedure GenerierungKüstenSeeGewässer;

private
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartenGeneratorKueste;

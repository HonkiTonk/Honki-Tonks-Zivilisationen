pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorKueste is

   procedure GenerierungKüstenSeeGewässer;

private
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   procedure GewässerFestlegen
     (YAchseSchleifenwertExtern, XAchseSchleifenwertExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseSchleifenwertExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XAchseSchleifenwertExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartenGeneratorKueste;

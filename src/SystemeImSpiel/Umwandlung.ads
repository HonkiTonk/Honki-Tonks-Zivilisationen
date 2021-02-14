pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, Karten;
use GlobaleDatentypen;

package Umwandlung is

   function KartenfeldNachKartenfeldPositiv (Koordinaten : GlobaleRecords.AchsenKartenfeldRecord) return GlobaleRecords.AchsenKartenfeldPositivRecord with
     Pre => Koordinaten.EAchse in GlobaleDatentypen.EbeneVorhanden and Koordinaten.YAchse in GlobaleDatentypen.KartenfeldPositiv and Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
     and Koordinaten.XAchse in GlobaleDatentypen.KartenfeldPositiv and Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

private
   
   KoordinatenUmgewandelt : GlobaleRecords.AchsenKartenfeldPositivRecord;

end Umwandlung;

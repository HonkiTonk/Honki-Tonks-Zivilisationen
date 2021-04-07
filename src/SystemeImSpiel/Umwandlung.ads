pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;

package Umwandlung is

   function KartenfeldNachKartenfeldPositiv
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre  => (KoordinatenExtern.EAchse in GlobaleDatentypen.EbeneVorhanden and KoordinatenExtern.YAchse in GlobaleDatentypen.KartenfeldPositiv
                and KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse in GlobaleDatentypen.KartenfeldPositiv
                and KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
       Post => (KartenfeldNachKartenfeldPositiv'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KartenfeldNachKartenfeldPositiv'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

private
   
   KoordinatenUmgewandelt : GlobaleRecords.AchsenKartenfeldPositivRecord;

end Umwandlung;

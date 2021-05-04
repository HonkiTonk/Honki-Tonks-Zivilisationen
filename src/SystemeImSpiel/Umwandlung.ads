pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package Umwandlung is

   function KartenfeldNachKartenfeldPositiv
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.EAchse in GlobaleDatentypen.EbeneVorhanden
          and
            KoordinatenExtern.YAchse in GlobaleDatentypen.KartenfeldPositiv
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in GlobaleDatentypen.KartenfeldPositiv
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           (KartenfeldNachKartenfeldPositiv'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenfeldNachKartenfeldPositiv'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function EinheitNachKoordinaten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0
          and
            EinheitRasseNummerExtern.Platznummer > 0),
     Post =>
       (EinheitNachKoordinaten'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
        and
          EinheitNachKoordinaten'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);     
   
   function StadtNachKoordinaten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0
          and
            StadtRasseNummerExtern.Platznummer > 0),
     Post =>
       (StadtNachKoordinaten'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
        and
          StadtNachKoordinaten'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);       

private
   
   KoordinatenUmgewandelt : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KoordinatenEinheit: GlobaleRecords.AchsenKartenfeldPositivRecord;
   KoordinatenStadt: GlobaleRecords.AchsenKartenfeldPositivRecord;

end Umwandlung;

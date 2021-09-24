pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen, KartenRecords;
use GlobaleDatentypen;

with Karten;

package KISonstigesSuchen is

   function EigenesFeldSuchen
     (AktuellePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            AktuellePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            AktuellePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
private
   
   Bereich : GlobaleDatentypen.Sichtweite;
   BereichGeprüft : GlobaleDatentypen.SichtweiteMitNullwert;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   Ziel : KartenRecords.AchsenKartenfeldPositivRecord;
   
   function ZielSuchen
     (AktuellePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord;

end KISonstigesSuchen;

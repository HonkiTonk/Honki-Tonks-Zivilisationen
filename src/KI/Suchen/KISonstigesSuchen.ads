pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;

package KISonstigesSuchen is

   function EigenesFeldSuchen
     (AktuellePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
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
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   Ziel : GlobaleRecords.AchsenKartenfeldPositivRecord;

end KISonstigesSuchen;

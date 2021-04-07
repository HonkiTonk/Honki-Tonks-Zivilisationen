pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package BewegungBlockiert is

   function BlockiertStadtEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Bewegung_Enum
     with
     Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0));

private

   StadtWert : GlobaleRecords.RassePlatznummerRecord;
   EinheitWert : GlobaleRecords.RassePlatznummerRecord;

end BewegungBlockiert;

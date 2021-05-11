pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen, GlobaleKonstanten;
use GlobaleDatentypen;

with Karten;

package BewegungBlockiert is

   function BlockiertStadtEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Bewegung_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0),

         Global =>
           (Input => (GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch));

private

   StadtWert : GlobaleRecords.RassePlatznummerRecord;
   EinheitWert : GlobaleRecords.RassePlatznummerRecord;

end BewegungBlockiert;

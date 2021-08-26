pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen, GlobaleKonstanten;
use GlobaleDatentypen;

with Karten;

package BewegungBlockiert is

   function BlockiertStadtEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer),
         Global =>
           (Input => (GlobaleKonstanten.LeerEinheitStadtNummer)),
           Depends =>
             (BlockiertStadtEinheit'Result => (EinheitRasseNummerExtern, NeuePositionExtern),
              null => (GlobaleKonstanten.LeerEinheitStadtNummer));

private

   StadtWert : GlobaleRecords.RassePlatznummerRecord;
   EinheitWert : GlobaleRecords.RassePlatznummerRecord;

end BewegungBlockiert;

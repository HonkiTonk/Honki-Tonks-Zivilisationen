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
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer),
         Post =>
           (BlockiertStadtEinheit'Result = GlobaleDatentypen.Gegner_Blockiert
            or
              BlockiertStadtEinheit'Result = GlobaleDatentypen.Keine_Bewegung_Möglich
            or
              BlockiertStadtEinheit'Result = GlobaleDatentypen.Normale_Bewegung_Möglich),
     Global =>
       (Input => (GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch)),
       Depends =>
         (BlockiertStadtEinheit'Result => (EinheitRasseNummerExtern, NeuePositionExtern),
          null => (GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch));

private

   StadtWert : GlobaleRecords.RassePlatznummerRecord;
   EinheitWert : GlobaleRecords.RassePlatznummerRecord;

end BewegungBlockiert;

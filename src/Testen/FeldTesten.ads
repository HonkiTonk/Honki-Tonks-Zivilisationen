pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package FeldTesten is

   function BelegterGrundTesten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function BelegterGrundLeerTesten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   function BestimmteStadtBelegtGrund
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
end FeldTesten;

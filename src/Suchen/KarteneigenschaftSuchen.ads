pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package KarteneigenschaftSuchen is

   function KartenGrundEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0
          and
            EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)),
         Post =>
           (KartenGrundEinheitSuchen'Result > 0);

   function KartenFlussEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0
          and
            EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2));

   function KartenStraßeEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenVerbesserung
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0
          and
            EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2));

   function KartenVerbesserungEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenVerbesserung
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0
          and
            EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2));

   function KartenRessourceEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0
          and
            EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2));

private

   Straße : GlobaleDatentypen.KartenVerbesserung;
   Verbesserung : GlobaleDatentypen.KartenVerbesserung;

   Grund : GlobaleDatentypen.KartenGrund;
   Fluss : GlobaleDatentypen.KartenGrund;
   Ressource : GlobaleDatentypen.KartenGrund;


end KarteneigenschaftSuchen;

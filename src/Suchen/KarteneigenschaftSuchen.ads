pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package KarteneigenschaftSuchen is

   function KartenGrundEinheitSuchen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)),
         Post =>
           (KartenGrundEinheitSuchen'Result > 0);

   function KartenFlussEinheitSuchen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2));

   function KartenStraßeEinheitSuchen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenVerbesserung
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2));

   function KartenVerbesserungEinheitSuchen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenVerbesserung
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2));

   function KartenRessourceEinheitSuchen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2));

private

   Straße : GlobaleDatentypen.KartenVerbesserung;
   Verbesserung : GlobaleDatentypen.KartenVerbesserung;

   Grund : GlobaleDatentypen.KartenGrund;
   Fluss : GlobaleDatentypen.KartenGrund;
   Ressource : GlobaleDatentypen.KartenGrund;


end KarteneigenschaftSuchen;

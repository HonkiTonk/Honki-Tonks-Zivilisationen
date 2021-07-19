pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KIGefahrReaktion is

   procedure KIGefahrReaktion
     (EinheitRasseNummerExtern, FeindlicheEinheit : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
          and
            FeindlicheEinheit.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (FeindlicheEinheit.Rasse) /= GlobaleDatentypen.Leer);

private



end KIGefahrReaktion;

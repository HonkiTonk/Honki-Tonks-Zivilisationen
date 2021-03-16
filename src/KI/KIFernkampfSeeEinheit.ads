pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package KIFernkampfSeeEinheit is

   procedure KIFernkampfSeeEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2));

end KIFernkampfSeeEinheit;

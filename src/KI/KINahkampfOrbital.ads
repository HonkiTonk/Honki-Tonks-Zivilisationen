pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package KINahkampfOrbital is

   procedure KINahkampfOrbital (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

end KINahkampfOrbital;

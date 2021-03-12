pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package KIEinheitVerbessernOderVernichten is

   function KIEinheitVerbessern (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   function KIEinheitVernichten (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

end KIEinheitVerbessernOderVernichten;

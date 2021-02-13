pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;

package KINahkampfUnterirdisch is

   procedure KINahkampfUnterirdisch (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

end KINahkampfUnterirdisch;

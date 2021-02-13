pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;

package KIFernkampfSeeEinheit is

   procedure KIFernkampfSeeEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

end KIFernkampfSeeEinheit;

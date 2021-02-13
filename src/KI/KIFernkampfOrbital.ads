pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;

package KIFernkampfOrbital is

   procedure KIFernkampfOrbital (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

end KIFernkampfOrbital;

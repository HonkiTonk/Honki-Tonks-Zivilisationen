pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;

package KIFernkampfOrbital is

   procedure KIFernkampfOrbital (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

end KIFernkampfOrbital;

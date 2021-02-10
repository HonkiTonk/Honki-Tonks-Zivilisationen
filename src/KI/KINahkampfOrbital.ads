pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;

package KINahkampfOrbital is

   procedure KINahkampfOrbital (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

end KINahkampfOrbital;

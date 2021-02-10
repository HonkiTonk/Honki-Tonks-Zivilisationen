pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;

package KINahkampfLandEinheit is

   procedure KINahkampfLandEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

end KINahkampfLandEinheit;

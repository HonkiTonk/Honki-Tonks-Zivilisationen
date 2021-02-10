pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;

package KINahkampfLuftEinheit is

   procedure KINahkampfLuftEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

end KINahkampfLuftEinheit;

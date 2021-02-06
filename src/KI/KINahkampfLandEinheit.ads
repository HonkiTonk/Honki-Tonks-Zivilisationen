pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;

package KINahkampfLandEinheit is

   procedure KINahkampfLandEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

end KINahkampfLandEinheit;

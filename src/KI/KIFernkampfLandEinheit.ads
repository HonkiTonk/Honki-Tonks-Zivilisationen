with GlobaleDatentypen, GlobaleVariablen;

package KIFernkampfLandEinheit is

   procedure KIFernkampfLandEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

end KIFernkampfLandEinheit;

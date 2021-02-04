with GlobaleDatentypen, GlobaleVariablen;

package KIFernkampfLuftEinheit is

   procedure KIFernkampfLuftEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

end KIFernkampfLuftEinheit;

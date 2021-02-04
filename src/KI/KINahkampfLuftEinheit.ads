with GlobaleDatentypen, GlobaleVariablen;

package KINahkampfLuftEinheit is

   procedure KINahkampfLuftEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

end KINahkampfLuftEinheit;

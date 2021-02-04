with GlobaleDatentypen, GlobaleVariablen;

package KIFernkampfSeeEinheit is

   procedure KIFernkampfSeeEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

end KIFernkampfSeeEinheit;

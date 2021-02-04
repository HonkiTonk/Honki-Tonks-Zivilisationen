with GlobaleDatentypen, GlobaleVariablen;

package KINahkampfSeeEinheit is

   procedure KINahkampfSeeEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

end KINahkampfSeeEinheit;

with GlobaleDatentypen, GlobaleVariablen;

package KIGefahr is

   function KIGefahr (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) return Boolean with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

end KIGefahr;

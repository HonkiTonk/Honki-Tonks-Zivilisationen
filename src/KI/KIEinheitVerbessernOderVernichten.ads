with GlobaleDatentypen, GlobaleVariablen;

package KIEinheitVerbessernOderVernichten is

   function KIEinheitVerbessern (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) return Boolean with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   function KIEinheitVernichten (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) return Boolean with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

end KIEinheitVerbessernOderVernichten;

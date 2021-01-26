with GlobaleDatentypen, GlobaleVariablen, EinheitenDatenbank;

package KIEinheitVerbessernOderVernichten is

   function KIEinheitVerbessern (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) return Boolean;
   function KIEinheitVernichten (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) return Boolean;

end KIEinheitVerbessernOderVernichten;

pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;

package KIEinheitVerbessernOderVernichten is

   function KIEinheitVerbessern (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   function KIEinheitVernichten (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

end KIEinheitVerbessernOderVernichten;

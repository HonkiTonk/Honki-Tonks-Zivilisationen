pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;

package KIEinheitVerbessernOderVernichten is

   function KIEinheitVerbessern (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   function KIEinheitVernichten (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

end KIEinheitVerbessernOderVernichten;

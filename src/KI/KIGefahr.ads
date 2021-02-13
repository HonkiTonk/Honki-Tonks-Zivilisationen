pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;

package KIGefahr is

   function KIGefahr (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

private

   function Unbewaffnet return Boolean;
   function Nahkämpfer return Boolean;
   function Fernkämpfer return Boolean;

end KIGefahr;

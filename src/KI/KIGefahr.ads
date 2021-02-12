pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;

package KIGefahr is

   function KIGefahr (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

private

   function Unbewaffnet return Boolean;
   function Nahkämpfer return Boolean;
   function Fernkämpfer return Boolean;

end KIGefahr;

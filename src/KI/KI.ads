pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KI is

   procedure KI (RasseExtern : in GlobaleDatentypen.Rassen);

private

   procedure KIAKtivitätEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   procedure KIAktivitätStadt (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) with
     Pre => StadtNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

end KI;

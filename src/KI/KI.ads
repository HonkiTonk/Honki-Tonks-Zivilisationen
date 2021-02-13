pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package KI is

   procedure KI (RasseExtern : in GlobaleDatentypen.Rassen);

private

   EinheitTyp : GlobaleDatentypen.EinheitenTyp;

   EinheitenBeschäftigt : Natural;
   StadtBeschäftigt : Natural;

   EinheitRassePlatznummerID : GlobaleRecords.RassePlatznummerIDRecord;

   procedure AKtivitätEinheit (EinheitRasseNummerID : in GlobaleRecords.RassePlatznummerIDRecord) with
     Pre => EinheitRasseNummerID.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummerID.Rasse in GlobaleDatentypen.Rassen;

   procedure AKtivitätEinheitAbbrechen (EinheitRasseNummerID : in GlobaleRecords.RassePlatznummerIDRecord) with
     Pre => EinheitRasseNummerID.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummerID.Rasse in GlobaleDatentypen.Rassen;

   procedure AktivitätStadt (StadtRasseNummerID : in GlobaleRecords.RassePlatznummerIDRecord) with
     Pre => StadtRasseNummerID.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and StadtRasseNummerID.Rasse in GlobaleDatentypen.Rassen;

   procedure AktivitätStadtAbbrechen (StadtRasseNummerID : in GlobaleRecords.RassePlatznummerIDRecord) with
     Pre => StadtRasseNummerID.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and StadtRasseNummerID.Rasse in GlobaleDatentypen.Rassen;

end KI;

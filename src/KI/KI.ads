pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package KI is

   procedure KI (RasseExtern : in GlobaleDatentypen.Rassen);

private

   EinheitenBeschäftigt : Natural;
   StadtBeschäftigt : Natural;
   EinheitTyp : Natural;

   procedure AKtivitätEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure AKtivitätEinheitAbbrechen (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure AktivitätStadt (StadtRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => StadtRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and StadtRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure AktivitätStadtAbbrechen (StadtRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => StadtRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and StadtRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

end KI;

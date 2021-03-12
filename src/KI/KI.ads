pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package KI is

   procedure KI (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 2);

private

   EinheitTyp : GlobaleDatentypen.EinheitenTyp;

   EinheitenBeschäftigt : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   StadtBeschäftigt : GlobaleDatentypen.MaximaleEinheitenMitNullWert;

   EinheitRasseNummer : GlobaleRecords.RassePlatznummerRecord;

   procedure AKtivitätEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse > 0
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   procedure AKtivitätEinheitAbbrechen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse > 0
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   procedure AktivitätStadt (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer >= GlobaleVariablen.StadtGebaut'First (2) and StadtRasseNummer.Rasse > 0
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) = 2));

   procedure AktivitätStadtAbbrechen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer >= GlobaleVariablen.StadtGebaut'First (2) and StadtRasseNummer.Rasse > 0
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) = 2));

end KI;

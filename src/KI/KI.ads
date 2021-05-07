pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package KI is

   procedure KI
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 2);

private

   EinheitTyp : GlobaleDatentypen.EinheitenTyp;

   EinheitenBeschäftigt : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   StadtBeschäftigt : GlobaleDatentypen.MaximaleEinheitenMitNullWert;

   SiedlerVorhanden : Natural;

   EinheitRasseNummer : GlobaleRecords.RassePlatznummerRecord;

   procedure AKtivitätEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   procedure AKtivitätEinheitAbbrechen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   procedure AktivitätStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebaut'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = 2);

   procedure AktivitätStadtAbbrechen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebaut'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = 2);

end KI;

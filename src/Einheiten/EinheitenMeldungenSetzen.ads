pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, EinheitStadtRecords;
use GlobaleDatentypen;

package EinheitenMeldungenSetzen is

   procedure EinheitenMeldungenSetzenRundenEnde;

   procedure EinheitMeldungSetzenEreignis
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EreignisExtern : in GlobaleDatentypen.Einheit_Meldung_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze);

private

   ArtDerMeldung : GlobaleDatentypen.Einheit_Meldung_Art_Enum;

end EinheitenMeldungenSetzen;

pragma SPARK_Mode (On);

with SonstigeDatentypen, GlobaleVariablen, EinheitStadtRecords, EinheitStadtDatentypen;
use SonstigeDatentypen;

package EinheitenMeldungenSetzen is

   procedure EinheitenMeldungenSetzenRundenEnde;

   procedure EinheitMeldungSetzenEreignis
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EreignisExtern : in EinheitStadtDatentypen.Einheit_Meldung_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze);

private

   ArtDerMeldung : EinheitStadtDatentypen.Einheit_Meldung_Art_Enum;

end EinheitenMeldungenSetzen;

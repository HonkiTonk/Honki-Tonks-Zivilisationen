pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with SystemKonstanten;

package EinheitenMeldungenSetzen is

   procedure EinheitenMeldungenSetzenRundenEnde;

   procedure EinheitMeldungSetzenEreignis
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EreignisExtern : in EinheitStadtDatentypen.Einheit_Meldung_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze);

private

   ArtDerMeldung : EinheitStadtDatentypen.Einheit_Meldung_Art_Enum;

end EinheitenMeldungenSetzen;

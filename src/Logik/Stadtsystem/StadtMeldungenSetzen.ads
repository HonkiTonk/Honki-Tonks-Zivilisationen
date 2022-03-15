pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with SystemKonstanten;

package StadtMeldungenSetzen is

   procedure StadtMeldungenSetzenRundenEnde;
   
   procedure StadtMeldungSetzenEreignis
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EreignisExtern : in EinheitStadtDatentypen.Stadt_Meldungen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze);
   
private
   
   ArtDerMeldung : EinheitStadtDatentypen.Stadt_Meldung_Art_Enum;

end StadtMeldungenSetzen;

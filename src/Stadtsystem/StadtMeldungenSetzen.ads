pragma SPARK_Mode (On);

with SonstigeDatentypen, GlobaleVariablen, EinheitStadtRecords, EinheitStadtDatentypen;
use SonstigeDatentypen;

package StadtMeldungenSetzen is

   procedure StadtMeldungenSetzenRundenEnde;
   
   procedure StadtMeldungSetzenEreignis
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EreignisExtern : in EinheitStadtDatentypen.Stadt_Meldungen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze);
   
private
   
   ArtDerMeldung : EinheitStadtDatentypen.Stadt_Meldung_Art_Enum;

end StadtMeldungenSetzen;

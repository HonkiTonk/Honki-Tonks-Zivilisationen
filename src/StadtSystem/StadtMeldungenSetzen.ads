pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package StadtMeldungenSetzen is

   procedure StadtMeldungenSetzenRundenEnde;
   
   procedure StadtMeldungSetzenEreignis
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EreignisExtern : in GlobaleDatentypen.Stadt_Meldungen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze);
   
private
   
   ArtDerMeldung : GlobaleDatentypen.Stadt_Meldung_Art_Enum;

end StadtMeldungenSetzen;

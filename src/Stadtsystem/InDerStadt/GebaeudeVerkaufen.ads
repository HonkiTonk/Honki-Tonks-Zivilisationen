pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package GebaeudeVerkaufen is

   procedure GebäudeVerkaufen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);

private

   Aufschlag : GlobaleDatentypen.KartenfeldPositivMitNullwert;

end GebaeudeVerkaufen;

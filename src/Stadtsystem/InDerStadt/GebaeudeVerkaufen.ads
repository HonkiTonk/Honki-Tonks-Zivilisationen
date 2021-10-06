pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenDatentypen;

package GebaeudeVerkaufen is

   procedure GebäudeVerkaufen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch);

private

   Aufschlag : KartenDatentypen.KartenfeldPositivMitNullwert;

end GebaeudeVerkaufen;

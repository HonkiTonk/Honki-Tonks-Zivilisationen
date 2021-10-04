pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleDatentypen, GlobaleVariablen, SonstigeDatentypen;
use GlobaleDatentypen, SonstigeDatentypen;

package InDerStadt is

   procedure InDerStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch);

private

   Befehl : GlobaleDatentypen.Tastenbelegung_Enum;

end InDerStadt;

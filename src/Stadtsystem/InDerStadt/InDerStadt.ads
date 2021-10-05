pragma SPARK_Mode (On);

with EinheitStadtRecords, SystemDatentypen, GlobaleVariablen, SonstigeDatentypen;
use SonstigeDatentypen;

package InDerStadt is

   procedure InDerStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch);

private

   Befehl : SystemDatentypen.Tastenbelegung_Enum;

end InDerStadt;

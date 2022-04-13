pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;

package KarteStadt is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch_Enum);

end KarteStadt;

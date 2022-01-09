pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;

package StadtGebaeudeBauen is

   procedure GebäudeFertiggestellt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);

end StadtGebaeudeBauen;

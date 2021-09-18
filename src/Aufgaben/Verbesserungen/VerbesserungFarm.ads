pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package VerbesserungFarm is
   
   function VerbesserungFarm
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
end VerbesserungFarm;

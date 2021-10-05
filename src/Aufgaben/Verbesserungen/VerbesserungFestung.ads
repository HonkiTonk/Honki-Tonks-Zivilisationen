pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenDatentypen;

package VerbesserungFestung is

   function VerbesserungFestung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);

end VerbesserungFestung;

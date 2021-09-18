pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package AufgabenAllgemein is

   procedure Beschreibung
     (KartenVerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum);

   procedure Nullsetzung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

end AufgabenAllgemein;

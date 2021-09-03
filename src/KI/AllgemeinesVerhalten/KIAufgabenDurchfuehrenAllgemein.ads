pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package KIAufgabenDurchfuehrenAllgemein is

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

end KIAufgabenDurchfuehrenAllgemein;

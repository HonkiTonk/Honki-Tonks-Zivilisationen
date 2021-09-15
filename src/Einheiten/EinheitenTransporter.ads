pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package EinheitenTransporter is

   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert     
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   function KannTransportiertWerden
     (LadungExtern : in GlobaleRecords.RassePlatznummerRecord;
      TransporterExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (LadungExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (LadungExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (LadungExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            TransporterExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= GlobaleDatentypen.Leer);
   
private
   
   AktuelleAuswahl : GlobaleDatentypen.EinheitenIDMitNullWert;
   Ende : GlobaleDatentypen.EinheitenIDMitNullWert;
   AktuellePosition : GlobaleDatentypen.EinheitenIDMitNullWert;
   Transportiert : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   
   function EinheitAuswählen
     return GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   
   function PlatzFrei
     (TransporterExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean;

end EinheitenTransporter;

pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, EinheitStadtRecords, SonstigeDatentypen, EinheitStadtDatentypen;
use GlobaleDatentypen, SonstigeDatentypen;

package EinheitenTransporter is

   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (LadungExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (LadungExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (LadungExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            TransporterExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= SonstigeDatentypen.Leer);
   
private
   
   AktuelleAuswahl : EinheitStadtDatentypen.EinheitenIDMitNullWert;
   Ende : EinheitStadtDatentypen.EinheitenIDMitNullWert;
   AktuellePosition : EinheitStadtDatentypen.EinheitenIDMitNullWert;
   Transportiert : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   function EinheitAuswählen
     return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   function PlatzFrei
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;

end EinheitenTransporter;

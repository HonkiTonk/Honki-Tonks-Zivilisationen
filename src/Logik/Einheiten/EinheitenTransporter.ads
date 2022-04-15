pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;

package EinheitenTransporter is

   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (LadungExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (LadungExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (LadungExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            TransporterExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
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

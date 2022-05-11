pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;
with EinheitenDatentypen;
with SonstigeVariablen;

package EinheitenTransporter is

   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre =>
         (LadungExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (LadungExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (LadungExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
private
   
   AktuelleAuswahl : EinheitenDatentypen.EinheitenIDMitNullWert;
   Ende : EinheitenDatentypen.EinheitenIDMitNullWert;
   AktuellePosition : EinheitenDatentypen.EinheitenIDMitNullWert;
   Transportiert : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   function EinheitAuswählen
     return EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   function PlatzFrei
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre =>
         (TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

end EinheitenTransporter;

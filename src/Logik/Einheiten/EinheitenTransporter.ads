pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with SonstigeVariablen;

package EinheitenTransporter is

   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      TransporterExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
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
   
   AktuelleAuswahl : EinheitStadtDatentypen.EinheitenIDMitNullWert;
   Ende : EinheitStadtDatentypen.EinheitenIDMitNullWert;
   AktuellePosition : EinheitStadtDatentypen.EinheitenIDMitNullWert;
   Transportiert : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   function EinheitAuswählen
     return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   function PlatzFrei
     (TransporterExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return Boolean;

end EinheitenTransporter;

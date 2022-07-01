pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with EinheitenDatentypen;
with SpielVariablen;

package EinheitenTransporterAuswahlTerminal is

   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   AktuelleAuswahl : EinheitenDatentypen.EinheitenIDMitNullWert;
   Ende : EinheitenDatentypen.EinheitenIDMitNullWert;
   AktuellePosition : EinheitenDatentypen.EinheitenIDMitNullWert;
   Transportiert : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   
   
   function EinheitAuswählen
     return EinheitenDatentypen.MaximaleEinheitenMitNullWert;

end EinheitenTransporterAuswahlTerminal;

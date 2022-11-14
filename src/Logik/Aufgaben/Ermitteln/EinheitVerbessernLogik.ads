with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with EinheitenDatentypen;

package EinheitVerbessernLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function VerbesserungEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   IDEinheit : EinheitenDatentypen.EinheitenID;
   
   IDNeueEinheit : EinheitenDatentypen.EinheitenIDMitNullWert;

end EinheitVerbessernLogik;

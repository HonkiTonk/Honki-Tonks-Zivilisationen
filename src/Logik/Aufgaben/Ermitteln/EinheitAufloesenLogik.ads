with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

with LeseGrenzen;

package EinheitAufloesenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end EinheitAufloesenLogik;
